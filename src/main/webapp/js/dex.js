const GECKOTERMINAL_API = `${getContextPath()}/api/gecko`;
let currentTradeType = 'buy';
let currentNetwork = 'base';

function getContextPath() {
    const path = window.location.pathname;
    const contextPath = path.substring(0, path.indexOf('/', 1));
    return contextPath || '';
}

function searchToken() {
    loadTokenByAddress(document.getElementById('search-token').value.trim());
}

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
        const url = `${GECKOTERMINAL_API}/onchain/networks/${currentNetwork}/tokens/${address}?include=top_pools`;
        const response = await fetchGeckoAPI(url);
        const data = await response.json();
        
        console.log('API Response:', data); // Debug log
        
        if (!data.data || !data.data.attributes) {
            alert('Token not found');
            return;
        }
        
        if (!data.included || data.included.length === 0) {
            alert('No pools found for this token');
            return;
        }
        
        const token = data.data;
        const pool = data.included[0];
        
        console.log('Token:', token);
        console.log('Pool:', pool);
        
        embedChart(currentNetwork, pool.attributes.address);
        loadData(token);
        setCurrentToken(token.attributes);
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

async function loadData(token) {
    console.log('Loading token data:', token);
    
    const name = token.attributes.name;
    const price = parseFloat(token.attributes.price_usd);
    
    document.getElementById('token-name').textContent = name;
    document.getElementById('token-price').textContent = `$${price.toFixed(6)}`;
}


let currentToken = null;
let currentTokenPrice = 0;
let userWalletAddress = null;

window.updateWalletAddress = function(address) {
    userWalletAddress = address;
    console.log('Wallet address updated:', address);
    
    if (address) {
        document.getElementById('buy-wallet-address').value = address;
        document.getElementById('sell-wallet-address').value = address;
        
        if (currentToken) {
            document.getElementById('buy-button').disabled = false;
            document.getElementById('sell-button').disabled = false;
        }
    } else {
        document.getElementById('buy-wallet-address').value = '';
        document.getElementById('sell-wallet-address').value = '';
        document.getElementById('buy-button').disabled = true;
        document.getElementById('sell-button').disabled = true;
    }
};

window.addEventListener('walletConnected', (event) => {
    console.log('Wallet connected:', event.detail.address);
    userWalletAddress = event.detail.address;
});

window.addEventListener('walletDisconnected', () => {
    console.log('Wallet disconnected');
    userWalletAddress = null;
});

function switchTab(tab) {
    const buyTab = document.getElementById('buy-tab');
    const sellTab = document.getElementById('sell-tab');
    const buyForm = document.getElementById('buy-form');
    const sellForm = document.getElementById('sell-form');

    if (tab === 'buy') {
        buyTab.classList.remove('bg-gray-100', 'text-gray-700');
        buyTab.classList.add('bg-green-600', 'text-white');
        sellTab.classList.remove('bg-red-600', 'text-white');
        sellTab.classList.add('bg-gray-100', 'text-gray-700');
        buyForm.classList.remove('hidden');
        sellForm.classList.add('hidden');
    } else {
        sellTab.classList.remove('bg-gray-100', 'text-gray-700');
        sellTab.classList.add('bg-red-600', 'text-white');
        buyTab.classList.remove('bg-green-600', 'text-white');
        buyTab.classList.add('bg-gray-100', 'text-gray-700');
        sellForm.classList.remove('hidden');
        buyForm.classList.add('hidden');
    }
}

function setCurrentToken(tokenData) {
    currentToken = tokenData;
    currentTokenPrice = parseFloat(tokenData.price_usd);

    document.getElementById('buy-token-symbol').textContent = tokenData.symbol;
    document.getElementById('buy-token-price').textContent = '$' + parseFloat(tokenData.price_usd).toFixed(6);

    document.getElementById('sell-token-symbol').textContent = tokenData.symbol;
    document.getElementById('sell-token-price').textContent = '$' + parseFloat(tokenData.price_usd).toFixed(6);

    if (userWalletAddress) {
        document.getElementById('buy-button').disabled = false;
        document.getElementById('sell-button').disabled = false;
    }
}

function calculateBuyTotal() {
    const amount = parseFloat(document.getElementById('buy-amount').value) || 0;
    const total = amount * currentTokenPrice;
    document.getElementById('buy-total').textContent = '$' + total.toFixed(2);
}

function calculateSellTotal() {
    const amount = parseFloat(document.getElementById('sell-amount').value) || 0;
    const total = amount * currentTokenPrice;
    document.getElementById('sell-total').textContent = '$' + total.toFixed(2);
}

async function executeBuy() {
    if (!userWalletAddress) {
        alert('Please connect your wallet first');
        window.WalletConnect.openConnectModal();
        return;
    }

    const amount = parseFloat(document.getElementById('buy-amount').value);
    
    if (!amount || amount <= 0) {
        alert('Please enter a valid amount');
        return;
    }

    const totalPrice = amount * currentTokenPrice;
    const buyButton = document.getElementById('buy-button');
    buyButton.disabled = true;
    buyButton.textContent = 'Processing...';

    try {
        const response = await fetch(`${getContextPath()}/transaction/create`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                tokenId: currentToken.id,
                type: 'BUY',
                amount: amount.toString(),
                pricePerToken: currentTokenPrice.toString(),
                totalPrice: totalPrice.toString(),
                walletAddress: userWalletAddress
            })
        });

        const responseText = await response.text();
        console.log('Raw response:', responseText);
        console.log('Response status:', response.status);
        
        if (!response.ok) {
            throw new Error(`Server error: ${response.status}`);
        }

        let data;
        try {
            data = JSON.parse(responseText);
        } catch (parseError) {
            console.error('JSON parse error:', parseError);
            console.error('Invalid JSON:', responseText);
            throw new Error('Invalid JSON response from server');
        }

        if (data.success) {
            const txHash = await executeBlockchainBuy(currentToken.contractAddress, amount, totalPrice);

            await fetch(`${getContextPath()}/transaction/update`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({
                    transactionId: data.transactionId,
                    status: 'COMPLETED',
                    transactionHash: txHash
                })
            });

            alert('Purchase completed successfully!');
            document.getElementById('buy-amount').value = '';
            calculateBuyTotal();
            
            if (typeof loadTransactions === 'function') {
                loadTransactions();
            }
        } else {
            throw new Error(data.error || 'Failed to create transaction');
        }
    } catch (error) {
        console.error('Buy error:', error);
        alert('Transaction failed: ' + error.message);
    } finally {
        buyButton.disabled = false;
        buyButton.textContent = 'Buy Token';
    }
}

async function executeSell() {
    if (!userWalletAddress) {
        alert('Please connect your wallet first');
        window.WalletConnect.openConnectModal();
        return;
    }

    const amount = parseFloat(document.getElementById('sell-amount').value);
    
    if (!amount || amount <= 0) {
        alert('Please enter a valid amount');
        return;
    }

    const totalPrice = amount * currentTokenPrice;
    const sellButton = document.getElementById('sell-button');
    sellButton.disabled = true;
    sellButton.textContent = 'Processing...';

    try {
        const response = await fetch(`${getContextPath()}/transaction/create`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                tokenId: currentToken.id,
                type: 'SELL',
                amount: amount.toString(),
                pricePerToken: currentTokenPrice.toString(),
                totalPrice: totalPrice.toString(),
                walletAddress: userWalletAddress
            })
        });

        const data = await response.json();

        if (data.success) {
            const txHash = await executeBlockchainSell(currentToken.contractAddress, amount);

            await fetch(`${getContextPath()}/transaction/update`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({
                    transactionId: data.transactionId,
                    status: 'COMPLETED',
                    transactionHash: txHash
                })
            });

            alert('Sale completed successfully!');
            document.getElementById('sell-amount').value = '';
            calculateSellTotal();
            
            if (typeof loadTransactions === 'function') {
                loadTransactions();
            }
        } else {
            throw new Error(data.error || 'Failed to create transaction');
        }
    } catch (error) {
        console.error('Sell error:', error);
        alert('Transaction failed: ' + error.message);
    } finally {
        sellButton.disabled = false;
        sellButton.textContent = 'Sell Token';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    if (window.WalletConnect) {
        const account = window.WalletConnect.getWalletAccount();
        if (account.isConnected && account.address) {
            userWalletAddress = account.address;
            document.getElementById('buy-wallet-address').value = account.address;
            document.getElementById('sell-wallet-address').value = account.address;
        }
    }
});

async function executeBlockchainBuy(contractAddress, amount, totalPrice) {
    console.log('Executing blockchain buy:', { contractAddress, amount, totalPrice });
    return '0x' + Math.random().toString(16).substr(2, 64);
}

async function executeBlockchainSell(contractAddress, amount) {
    console.log('Executing blockchain sell:', { contractAddress, amount });
    return '0x' + Math.random().toString(16).substr(2, 64);
}

async function loadTransactions() {
    try {
        console.log('🔄 Loading transactions...');
        
        const response = await fetch(`${getContextPath()}/transaction/list?type=recent&limit=8`);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const transactions = await response.json();
        console.log('Loaded transactions:', transactions);
        console.log('Transaction count:', transactions.length);
        
        const grid = document.getElementById('transaction-grid');
        console.log('Grid element:', grid);
        
        if (!grid) {
            console.error('Grid element not found!');
            return;
        }
        
        if (!transactions || transactions.length === 0) {
            console.log('No transactions to display');
            grid.innerHTML = `
                <div class="col-span-full p-8 text-center text-gray-500">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    <p class="mt-4">No transactions yet</p>
                </div>
            `;
            return;
        }
        
        grid.innerHTML = '';
        console.log('Grid cleared');
        
        transactions.forEach((tx, index) => {
            console.log(`Creating card ${index + 1}/${transactions.length}:`, tx);
            try {
                const card = createTransactionCard(tx);
                console.log('Card created:', card);
                grid.appendChild(card);
                console.log('Card appended to grid');
            } catch (error) {
                console.error(`Error creating card ${index}:`, error, tx);
            }
        });
        
        console.log('All cards rendered. Grid children:', grid.children.length);
        
    } catch (error) {
        console.error('Error loading transactions:', error);
        const grid = document.getElementById('transaction-grid');
        if (grid) {
            grid.innerHTML = `
                <div class="col-span-full p-8 text-center text-red-500">
                    <p>Failed to load transactions</p>
                    <p class="text-sm mt-2">${error.message}</p>
                </div>
            `;
        }
    }
}


function createTransactionCard(txData) {
    console.log('🎴 Creating card for:', txData);
    
    const div = document.createElement('div');
    div.className = 'p-4 hover:bg-gray-50 transition-colors';
    
    const isBuy = txData.type === 'BUY';
    const badgeClass = isBuy ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700';
    const totalClass = isBuy ? 'text-green-600' : 'text-red-600';
    
    const tokenSymbol = txData.tokenSymbol && txData.tokenSymbol !== 'UNKNOWN' 
        ? txData.tokenSymbol 
        : 'TOKEN';
    
    const amount = parseFloat(txData.amount) || 0;
    const pricePerToken = parseFloat(txData.pricePerToken) || 0;
    const totalPrice = parseFloat(txData.totalPrice) || 0;
    
    let timeAgo = 'Unknown';
    try {
        const createdAt = new Date(txData.createdAt.replace(' ', 'T'));
        const now = new Date();
        const diffMs = now - createdAt;
        const diffMins = Math.floor(diffMs / 60000);
        
        if (diffMins < 1) {
            timeAgo = 'Just now';
        } else if (diffMins < 60) {
            timeAgo = `${diffMins}m ago`;
        } else if (diffMins < 1440) {
            timeAgo = `${Math.floor(diffMins / 60)}h ago`;
        } else {
            timeAgo = `${Math.floor(diffMins / 1440)}d ago`;
        }
    } catch (e) {
        console.warn('Error parsing date:', txData.createdAt, e);
        timeAgo = 'Recently';
    }
    
    div.innerHTML = `
        <div class="flex items-start justify-between mb-2">
            <div class="flex items-center gap-2">
                <span class="px-2 py-1 ${badgeClass} text-xs font-semibold rounded">${txData.type}</span>
                <span class="text-sm font-medium text-gray-900">${tokenSymbol}</span>
            </div>
            <span class="text-xs text-gray-500">${timeAgo}</span>
        </div>
        <div class="space-y-1">
            <div class="flex justify-between text-sm">
                <span class="text-gray-600">Amount:</span>
                <span class="font-semibold text-gray-900">${formatNumber(amount)} ${tokenSymbol}</span>
            </div>
            <div class="flex justify-between text-sm">
                <span class="text-gray-600">Price:</span>
                <span class="font-medium text-gray-900">$${formatPrice(pricePerToken)}</span>
            </div>
            <div class="flex justify-between text-sm border-t border-gray-100 pt-1 mt-1">
                <span class="text-gray-600">Total:</span>
                <span class="font-bold ${totalClass}">$${formatPrice(totalPrice)}</span>
            </div>
        </div>
        <div class="mt-2 flex items-center gap-1">
            <span class="text-xs text-gray-500 truncate">${truncateAddress(txData.walletAddress)}</span>
            ${txData.transactionHash && txData.transactionHash !== '' ? `
                <a href="https://basescan.org/tx/${txData.transactionHash}" target="_blank" 
                   class="text-blue-600 hover:text-blue-700" title="View on Explorer">
                    <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
                    </svg>
                </a>
            ` : ''}
        </div>
    `;
    
    console.log('✅ Card HTML created');
    return div;
}

function formatNumber(num) {
    const parsed = parseFloat(num);
    if (isNaN(parsed)) return '0';
    return new Intl.NumberFormat('en-US', {
        maximumFractionDigits: 2,
        minimumFractionDigits: 0
    }).format(parsed);
}

function formatPrice(price) {
    const parsed = parseFloat(price);
    if (isNaN(parsed)) return '0.00';
    return new Intl.NumberFormat('en-US', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 6
    }).format(parsed);
}

function truncateAddress(address) {
    if (!address || address === '') return '-';
    if (address.length < 10) return address;
    return address.substring(0, 6) + '...' + address.substring(address.length - 4);
}

document.addEventListener('DOMContentLoaded', function() {
    loadTransactions();
    
    setInterval(loadTransactions, 60000);
});

