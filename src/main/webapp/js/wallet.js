import { createAppKit } from '@reown/appkit';
import { mainnet, base } from '@reown/appkit/networks';
import { WagmiAdapter } from '@reown/appkit-adapter-wagmi';
import { getAccount, disconnect, watchAccount } from '@wagmi/core';

// 1. Get projectId dari https://dashboard.reown.com
const projectId = 'fd1a1f2a6addc16ab345942ee57a3531'; // GANTI INI!

// 2. Setup networks yang akan digunakan
export const networks = [mainnet, base];

// 3. Setup Wagmi adapter
const wagmiAdapter = new WagmiAdapter({
  projectId,
  networks
});

// 4. Configure metadata
const metadata = {
  name: 'Launchpad',
  description: 'Crypto Token Launchpad Platform',
  url: 'https://' + window.location.host, // Ganti dengan domain kamu
  icons: ['https://avatars.githubusercontent.com/u/179229932']
};

// 5. Create AppKit modal
export const modal = createAppKit({
  adapters: [wagmiAdapter],
  networks,
  metadata,
  projectId,
  features: {
    analytics: true,
    email: false,
    socials: []
  }
});

// 6. Export wagmi config untuk smart contract interaction
export const wagmiConfig = wagmiAdapter.wagmiConfig;

// 7. Helper functions
export function openConnectModal() {
  modal.open();
}

export function openNetworkModal() {
  modal.open({ view: 'Networks' });
}

export function getWalletAccount() {
  return getAccount(wagmiConfig);
}

export function disconnectWallet() {
  disconnect(wagmiConfig);
}

// 8. Watch account changes
export function onAccountChange(callback) {
  return watchAccount(wagmiConfig, {
    onChange: callback
  });
}

// 9. Initialize on page load
window.addEventListener('DOMContentLoaded', () => {
  console.log('Wallet integration initialized');
  
  // Update UI when account changes
  onAccountChange((account) => {
    updateWalletUI(account);
  });
  
  // Initial UI update
  const account = getWalletAccount();
  updateWalletUI(account);
});

// 10. Update UI helper
function updateWalletUI(account) {
  const connectBtn = document.getElementById('connect-wallet-btn');
  const walletAddress = document.getElementById('wallet-address');
  const disconnectBtn = document.getElementById('disconnect-wallet-btn');
  
  if (account.isConnected && account.address) {
    if (connectBtn) connectBtn.style.display = 'none';
    if (walletAddress) {
      walletAddress.textContent = `${account.address.slice(0, 6)}...${account.address.slice(-4)}`;
      walletAddress.style.display = 'inline-block';
    }
    if (disconnectBtn) disconnectBtn.style.display = 'inline-block';

    updateDEXWalletAddress(account.address);
  } else {
    if (connectBtn) connectBtn.style.display = 'inline-block';
    if (walletAddress) walletAddress.style.display = 'none';
    if (disconnectBtn) disconnectBtn.style.display = 'none';

    updateDEXWalletAddress(null);
  }
}

function updateDEXWalletAddress(address) {
  const buyWalletInput = document.getElementById('buy-wallet-address');
  const sellWalletInput = document.getElementById('sell-wallet-address');
  const buyButton = document.getElementById('buy-button');
  const sellButton = document.getElementById('sell-button');
  
  if (address) {
    // Update input fields
    if (buyWalletInput) {
      buyWalletInput.value = address;
    }
    if (sellWalletInput) {
      sellWalletInput.value = address;
    }
    
    // Enable buttons jika token sudah dipilih
    if (buyButton && window.currentToken) {
      buyButton.disabled = false;
    }
    if (sellButton && window.currentToken) {
      sellButton.disabled = false;
    }
    
    // Trigger custom event untuk script lain
    window.dispatchEvent(new CustomEvent('walletConnected', { 
      detail: { address } 
    }));
    
    // Update global variable untuk digunakan di trading functions
    if (typeof updateWalletAddress === 'function') {
      updateWalletAddress(address);
    }
  } else {
    // Clear inputs
    if (buyWalletInput) {
      buyWalletInput.value = '';
      buyWalletInput.placeholder = 'Connect wallet first';
    }
    if (sellWalletInput) {
      sellWalletInput.value = '';
      sellWalletInput.placeholder = 'Connect wallet first';
    }
    
    // Disable buttons
    if (buyButton) buyButton.disabled = true;
    if (sellButton) sellButton.disabled = true;
    
    // Trigger custom event
    window.dispatchEvent(new CustomEvent('walletDisconnected'));
    
    // Update global variable
    if (typeof updateWalletAddress === 'function') {
      updateWalletAddress(null);
    }
  }
}

// 12. Get current wallet address (helper function)
export function getCurrentWalletAddress() {
  const account = getWalletAccount();
  return account.isConnected ? account.address : null;
}

// Export untuk digunakan di global window
window.WalletConnect = {
  openConnectModal,
  openNetworkModal,
  getWalletAccount,
  disconnectWallet,
  onAccountChange,
  getCurrentWalletAddress,
  updateDEXWalletAddress
};