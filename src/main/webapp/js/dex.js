const GECKOTERMINAL_API = `${getContextPath()}/api/gecko`;
let currentTradeType = 'buy';
let currentNetwork = 'base';
let currentPoolAddress = null;
let currentTokenData = null;

function getContextPath() {
    const path = window.location.pathname;
    const contextPath = path.substring(0, path.indexOf('/', 1));
    return contextPath || '';
}

function searchToken() {
    loadTokenByAddress(document.getElementById('search-token').value.trim());
}

// Initialize page
document.addEventListener('DOMContentLoaded', async () => {
    setupEventListeners();
});

function setupEventListeners() {
    document.getElementById('network-select').addEventListener('change', (event) => {
        currentNetwork = event.target.value;
    });
}

async function fetchGeckoAPI(url) {
    const response = await fetch(url);
    
    if (!response.ok) {
        throw new Error(`API request failed: ${response.statusText}`);
    }
    
    return response;
}


async function loadTokenByAddress(address) {
    try {
        const url = `${GECKOTERMINAL_API}/onchain/networks/${currentNetwork}/tokens/${address}/pools?page=1`;
        const response = await fetchGeckoAPI(url);
        const data = await response.json();
        
        if (data.data && data.data.length > 0) {
            const pool = data.data[0];
            embedChart(currentNetwork, pool.attributes.address);
        } else {
            alert('No pools found for this token');
        }
    } catch (error) {
        console.error('Error loading token:', error);
        alert('Failed to load token data. Please try again.');
    }
}

function embedChart(network, poolAddress) {
    const chartContainer = document.getElementById('chart-container');
    const embedUrl = `https://www.geckoterminal.com/${network}/pools/${poolAddress}?embed=1&info=0&swaps=0&light_chart=1&chart_type=market_cap&resolution=4h&bg_color=ffffff`;
    
    chartContainer.innerHTML = `
        <iframe
            id="geckoterminal-embed"
            title="GeckoTerminal Embed"
            src="${embedUrl}"
            frameborder="0"
            allow="clipboard-write"
            allowfullscreen
            style="width: 100%; height: 600px; border: 0;"
        ></iframe>
    `;
}


// Load pool data and embed chart
// async function loadPoolData(pool) {
//     currentPoolAddress = pool.attributes.address;
//     const baseToken = pool.relationships.base_token.data;
//     const quoteToken = pool.relationships.quote_token.data;
    
//     // Update token info
//     document.getElementById('token-name').textContent = pool.attributes.name;
//     document.getElementById('token-price').textContent = `$${parseFloat(pool.attributes.base_token_price_usd).toFixed(6)}`;
    
//     // Update pool info
//     document.getElementById('pool-volume').textContent = `$${formatNumber(pool.attributes.volume_usd.h24)}`;
//     document.getElementById('pool-liquidity').textContent = `$${formatNumber(pool.attributes.reserve_in_usd)}`;
//     document.getElementById('pool-txns').textContent = formatNumber(pool.attributes.transactions.h24.buys + pool.attributes.transactions.h24.sells);
    
//     const priceChange = pool.attributes.price_change_percentage.h24;
//     const changeElement = document.getElementById('pool-change');
//     changeElement.textContent = `${priceChange > 0 ? '+' : ''}${priceChange.toFixed(2)}%`;
//     changeElement.className = `text-lg font-semibold ${priceChange >= 0 ? 'text-green-600' : 'text-red-600'}`;
    
//     // Show pool info section
//     document.getElementById('pool-info').style.display = 'block';
    
//     // Embed GeckoTerminal chart
//     embedChart(currentNetwork, currentPoolAddress);
    
//     // Update trading panel
//     updateTradingPanel(pool);
// }


// // Update trading panel with token info
// function updateTradingPanel(pool) {
//     currentTokenData = pool;
//     document.getElementById('receive-token').textContent = pool.attributes.name.split('/')[0].trim();
//     document.getElementById('exchange-rate').textContent = `1 ETH = ${(1 / parseFloat(pool.attributes.base_token_price_usd)).toFixed(2)} ${pool.attributes.name.split('/')[0].trim()}`;
// }

// // Set trade type (buy/sell)
// function setTradeType(type) {
//     currentTradeType = type;
//     const buyTab = document.getElementById('buy-tab');
//     const sellTab = document.getElementById('sell-tab');
    
//     if (type === 'buy') {
//         buyTab.className = 'flex-1 py-2 px-4 font-semibold rounded-lg bg-green-500 text-white';
//         sellTab.className = 'flex-1 py-2 px-4 font-semibold rounded-lg bg-gray-200 text-gray-700';
//     } else {
//         buyTab.className = 'flex-1 py-2 px-4 font-semibold rounded-lg bg-gray-200 text-gray-700';
//         sellTab.className = 'flex-1 py-2 px-4 font-semibold rounded-lg bg-red-500 text-white';
//     }
// }

// // Calculate receive amount based on pay amount
// function calculateReceiveAmount() {
//     if (!currentTokenData) return;
    
//     const payAmount = parseFloat(document.getElementById('pay-amount').value) || 0;
//     const price = parseFloat(currentTokenData.attributes.base_token_price_usd);
//     const receiveAmount = payAmount / price;
    
//     document.getElementById('receive-amount').value = receiveAmount.toFixed(6);
// }

// // Swap tokens (reverse buy/sell)
// function swapTokens() {
//     const payToken = document.getElementById('pay-token').textContent;
//     const receiveToken = document.getElementById('receive-token').textContent;
    
//     document.getElementById('pay-token').textContent = receiveToken;
//     document.getElementById('receive-token').textContent = payToken;
    
//     setTradeType(currentTradeType === 'buy' ? 'sell' : 'buy');
// }

// // Execute trade
// function executeTrade(event) {
//     event.preventDefault();
    
//     // Check if wallet is connected
//     if (typeof WalletConnect === 'undefined' || !WalletConnect.getWalletAccount().isConnected) {
//         alert('Please connect your wallet first');
//         WalletConnect.openConnectModal();
//         return false;
//     }
    
//     const payAmount = document.getElementById('pay-amount').value;
//     if (!payAmount || parseFloat(payAmount) <= 0) {
//         alert('Please enter a valid amount');
//         return false;
//     }
    
//     // In production, execute actual swap via smart contract
//     alert(`${currentTradeType === 'buy' ? 'Buying' : 'Selling'} ${payAmount} tokens. This is a demo - implement actual swap logic here.`);
//     return false;
// }

// // Utility function to format large numbers
// function formatNumber(num) {
//     if (num >= 1000000) {
//         return (num / 1000000).toFixed(2) + 'M';
//     } else if (num >= 1000) {
//         return (num / 1000).toFixed(2) + 'K';
//     }
//     return num.toFixed(2);
// }
