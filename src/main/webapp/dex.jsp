<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DEX - Launchpad</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/output.css" rel="stylesheet">
</head>
<body class="bg-white min-h-screen font-[Poppins]">
    <%
        Boolean loggedIn = (Boolean) session.getAttribute("loggedIn");
        String userEmail = (String) session.getAttribute("userEmail");
        boolean isLoggedIn = (loggedIn != null && loggedIn);
    %>
    <header class="bg-white inset-x-0 top-0 z-50">
        <nav aria-label="Global" class="flex items-center justify-between p-6 lg:px-8">
        <div class="flex lg:flex-1">
            <a href="#" class="-m-1.5 p-1.5">
            <span class="sr-only">Your Company</span>
            <img src="https://tailwindcss.com/plus-assets/img/logos/mark.svg?color=blue&shade=600" alt="" class="h-8 w-auto" />
            </a>
        </div>
        <div class="flex lg:hidden">
            <button type="button" command="show-modal" commandfor="mobile-menu" class="-m-2.5 inline-flex items-center justify-center rounded-md p-2.5 text-gray-700">
            <span class="sr-only">Open main menu</span>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" data-slot="icon" aria-hidden="true" class="size-6">
                <path d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
            </button>
        </div>
        <div class="hidden lg:flex lg:gap-x-12">
            <a href="./launch" class="text-sm/6 font-semibold text-gray-900">Launch</a>
            <a href="./dex" class="text-sm/6 font-semibold text-gray-900">Buy</a>
            <a href="./dex" class="text-sm/6 font-semibold text-gray-900">Sell</a>
            <a href="./about-us" class="text-sm/6 font-semibold text-gray-900">About Us</a>
        </div>
        <div class="hidden lg:flex lg:flex-1 lg:justify-end lg:items-center lg:gap-x-4">
            <button id="connect-wallet-btn" onclick="WalletConnect.openConnectModal()" class="rounded-md bg-blue-600 px-3.5 py-2 text-sm font-semibold text-white shadow-xs hover:bg-blue-500">
                Connect Wallet
            </button>
            <span id="wallet-address" class="text-sm font-semibold text-gray-900" style="display: none;"></span>
            <button id="disconnect-wallet-btn" onclick="WalletConnect.disconnectWallet()" class="text-sm font-semibold text-red-600 hover:text-red-500" style="display: none;">
                Disconnect
            </button>
            <% if (isLoggedIn) { 
                String displayName = (userEmail != null) ? userEmail : "User";
            %>
                <a href="./logout" class="text-sm font-semibold leading-6 text-gray-900 hover:text-gray-600 transition-colors">Log out</a>
                <a href="./profile" class="group relative block" title="Manage Profile">
                    <img 
                        src="https://ui-avatars.com/api/?name=<%= displayName %>&background=000&color=fff&rounded=true&size=40" 
                        alt="Profile" 
                        class="h-10 w-10 rounded-full border-2 border-transparent group-hover:border-gray-300 transition-all object-cover" 
                    />
                    <span class="absolute bottom-0 right-0 block h-2.5 w-2.5 rounded-full bg-green-400 ring-2 ring-white"></span>
                </a>
            <% } else { %>
                <a href="./login" class="text-sm font-semibold leading-6 text-gray-900">Log in <span aria-hidden="true">&rarr;</span></a>
            <% } %>
        </div>
        </nav>
        <el-dialog>
        <dialog id="mobile-menu" class="backdrop:bg-transparent lg:hidden">
            <div tabindex="0" class="fixed inset-0 focus:outline-none">
            <el-dialog-panel class="fixed inset-y-0 right-0 z-50 w-full overflow-y-auto bg-white p-6 sm:max-w-sm sm:ring-1 sm:ring-gray-900/10">
                <div class="flex items-center justify-between">
                <a href="#" class="-m-1.5 p-1.5">
                    <span class="sr-only">Your Company</span>
                    <img src="https://tailwindcss.com/plus-assets/img/logos/mark.svg?color=blue&shade=600" alt="" class="h-8 w-auto" />
                </a>
                <button type="button" command="close" commandfor="mobile-menu" class="-m-2.5 rounded-md p-2.5 text-gray-700">
                    <span class="sr-only">Close menu</span>
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" data-slot="icon" aria-hidden="true" class="size-6">
                    <path d="M6 18 18 6M6 6l12 12" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                </button>
                </div>
                <div class="mt-6 flow-root">
                <div class="-my-6 divide-y divide-gray-500/10">
                    <div class="space-y-2 py-6">
                    <a href="./launch" class="-mx-3 block rounded-lg px-3 py-2 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Launch</a>
                    <a href="./dex" class="-mx-3 block rounded-lg px-3 py-2 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Buy</a>
                    <a href="./dex" class="-mx-3 block rounded-lg px-3 py-2 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Sell</a>
                    <a href="./about-us" class="-mx-3 block rounded-lg px-3 py-2 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">About Us</a>
                    </div>
                    <div class="py-6">
                        <button id="connect-wallet-btn" onclick="WalletConnect.openConnectModal()" class="rounded-md bg-blue-600 px-3.5 py-2 text-sm font-semibold text-white shadow-xs hover:bg-blue-500">
                            Connect Wallet
                        </button>
                        <span id="wallet-address" class="text-sm font-semibold text-gray-900" style="display: none;"></span>
                        <button id="disconnect-wallet-btn" onclick="WalletConnect.disconnectWallet()" class="text-sm font-semibold text-red-600 hover:text-red-500" style="display: none;">
                            Disconnect
                        </button>
                        <% if (isLoggedIn) {
                            String displayName = (userEmail != null) ? userEmail : "User";
                        %>
                            <div class="relative -mx-3 mb-2 pt-4">
                                <a href="./profile" class="flex items-center gap-3 rounded-lg px-3 py-3 hover:bg-gray-50 transition-all group">
                                    <img 
                                        src="https://ui-avatars.com/api/?name=<%= displayName %>&background=000&color=fff&rounded=true&size=40" 
                                        alt="Profile" 
                                        class="h-10 w-10 rounded-full object-cover border border-gray-200 group-hover:border-black transition-colors" 
                                    />
                                    
                                    <div class="flex flex-col">
                                        <span class="text-base font-semibold text-gray-900 leading-5">
                                            <%= displayName %>
                                        </span>
                                        <span class="text-xs font-medium text-gray-600 mt-0.5">
                                            Manage Profile &rarr;
                                        </span>
                                    </div>
                                </a>
                            </div>

                            <a href="./logout" class="-mx-3 block rounded-lg px-3 py-2.5 text-base font-semibold text-red-600 hover:bg-red-50 hover:text-red-700 transition-colors">
                                Log out
                            </a>

                        <% } else { %>
                            <a href="./login" class="-mx-3 block rounded-lg px-3 py-2.5 text-base font-semibold text-gray-900 hover:bg-gray-50">
                                Log in
                            </a>
                        <% } %>
                    </div>
                </div>
                </div>
            </el-dialog-panel>
            </div>
        </dialog>
        </el-dialog>
    </header>

    <main class="container mx-auto px-4 py-8">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Decentralized Exchange</h1>
            <p class="text-gray-600">Trade tokens directly on-chain with real-time market data</p>
        </div>

        <div class="mb-6">
            <div class="flex gap-4">
                <div class="flex-1">
                    <input type="text" id="search-token" placeholder="Search token by token address..." 
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                </div>
                <select id="network-select" class="px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="base">Base</option>
                </select>
                <button onclick="searchToken()" class="px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-500">
                    Search
                </button>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
            <div class="lg:col-span-2 order-1">
                <div class="bg-white rounded-lg shadow-lg overflow-hidden">
                    <div class="p-4 border-b border-gray-200">
                        <div class="flex items-center justify-between">
                            <div>
                                <h2 class="text-xl font-bold text-gray-900" id="token-name">Select a Token</h2>
                                <p class="text-sm text-gray-600" id="token-price">$0.00</p>
                            </div>
                        </div>
                    </div>

                    <div id="chart-container" class="relative" style="height: 600px;">
                        <div class="flex items-center justify-center h-full text-gray-500">
                            <div class="text-center">
                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                </svg>
                                <p class="mt-4 text-sm">Search for a token to display trading chart!</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-1 order-2">
                <div class="bg-white rounded-lg shadow-lg overflow-hidden flex flex-col" style="height: 686px;">
                    <div class="flex border-b border-gray-200 shrink-0">
                        <button onclick="switchTab('buy')" id="buy-tab" 
                                class="flex-1 px-6 py-4 text-sm font-semibold text-white bg-green-600 hover:bg-green-700 transition-colors">
                            Buy
                        </button>
                        <button onclick="switchTab('sell')" id="sell-tab" 
                                class="flex-1 px-6 py-4 text-sm font-semibold text-gray-700 bg-gray-100 hover:bg-gray-200 transition-colors">
                            Sell
                        </button>
                    </div>

                    <div id="buy-form" class="p-6">
                        <h3 class="text-lg font-bold text-gray-900 mb-4">Buy Token</h3>
                        
                        <div class="space-y-4">
                            <div class="bg-gray-50 rounded-lg p-4">
                                <div class="flex items-center justify-between">
                                    <span class="text-sm text-gray-600">Selected Token:</span>
                                    <span id="buy-token-symbol" class="font-semibold text-gray-900">-</span>
                                </div>
                                <div class="flex items-center justify-between mt-2">
                                    <span class="text-sm text-gray-600">Current Price:</span>
                                    <span id="buy-token-price" class="font-semibold text-gray-900">$0.00</span>
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    Amount to Buy
                                </label>
                                <input type="number" id="buy-amount" 
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                                    placeholder="0.00" min="0" step="any" oninput="calculateBuyTotal()" />
                            </div>

                            <div class="bg-green-50 rounded-lg p-4">
                                <div class="flex items-center justify-between">
                                    <span class="text-sm font-medium text-gray-700">Total Price:</span>
                                    <span id="buy-total" class="text-xl font-bold text-green-600">$0.00</span>
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    Your Wallet Address
                                </label>
                                <input type="text" id="buy-wallet-address" readonly
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600 text-sm"
                                    placeholder="Connect wallet first" />
                            </div>

                            <button onclick="executeBuy()" 
                                    class="w-full py-3 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-colors"
                                    id="buy-button" disabled>
                                Buy Token
                            </button>

                            <p class="text-xs text-gray-500 text-center">
                                Transaction will be processed on-chain
                            </p>
                        </div>
                    </div>

                    <div id="sell-form" class="p-6 hidden">
                        <h3 class="text-lg font-bold text-gray-900 mb-4">Sell Token</h3>
                        
                        <div class="space-y-4">
                            <div class="bg-gray-50 rounded-lg p-4">
                                <div class="flex items-center justify-between">
                                    <span class="text-sm text-gray-600">Selected Token:</span>
                                    <span id="sell-token-symbol" class="font-semibold text-gray-900">-</span>
                                </div>
                                <div class="flex items-center justify-between mt-2">
                                    <span class="text-sm text-gray-600">Current Price:</span>
                                    <span id="sell-token-price" class="font-semibold text-gray-900">$0.00</span>
                                </div>
                                <div class="flex items-center justify-between mt-2">
                                    <span class="text-sm text-gray-600">Your Balance:</span>
                                    <span id="sell-token-balance" class="font-semibold text-gray-900">0</span>
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    Amount to Sell
                                </label>
                                <div class="relative">
                                    <input type="number" id="sell-amount" 
                                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500"
                                        placeholder="0.00" min="0" step="any" oninput="calculateSellTotal()" />
                                    <button onclick="setMaxSell()" 
                                            class="absolute right-2 top-1/2 -translate-y-1/2 px-3 py-1 text-xs font-semibold text-blue-600 hover:text-blue-700">
                                        MAX
                                    </button>
                                </div>
                            </div>

                            <div class="bg-red-50 rounded-lg p-4">
                                <div class="flex items-center justify-between">
                                    <span class="text-sm font-medium text-gray-700">You'll Receive:</span>
                                    <span id="sell-total" class="text-xl font-bold text-red-600">$0.00</span>
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    Your Wallet Address
                                </label>
                                <input type="text" id="sell-wallet-address" readonly
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600 text-sm"
                                    placeholder="Connect wallet first" />
                            </div>

                            <button onclick="executeSell()" 
                                    class="w-full py-3 bg-red-600 text-white font-semibold rounded-lg hover:bg-red-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-colors"
                                    id="sell-button" disabled>
                                Sell Token
                            </button>

                            <p class="text-xs text-gray-500 text-center">
                                Transaction will be processed on-chain
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow-lg overflow-hidden">
            <div class="p-6 border-b border-gray-200">
                <div class="flex items-center justify-between">
                    <div>
                        <h3 class="text-xl font-bold text-gray-900">Recent Transactions</h3>
                        <p class="text-sm text-gray-600 mt-1">Latest buy and sell orders on this platform</p>
                    </div>
                </div>
            </div>
            
            <div id="transaction-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 divide-x divide-y divide-gray-100">
                <div class="col-span-full p-8 text-center text-gray-500">
                    <div class="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
                    <p class="mt-4">Loading transactions...</p>
                </div>
            </div>
        </div>
    </main>


    <script type="module" src="js/wallet.bundle.js"></script>
    <script src="js/dex.js"></script>
</body>
</html>
