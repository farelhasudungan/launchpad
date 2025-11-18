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
    <header class="inset-x-0 top-0 z-50 bg-white/30 backdrop-blur-md">
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
            <% if (isLoggedIn) { %>
                <span class="text-sm/6 font-semibold text-gray-900 mr-4">Welcome, <%= userEmail %></span>
                <a href="./logout" class="text-sm/6 font-semibold text-gray-900">Log out</a>
            <% } else { %>
                <a href="./login" class="text-sm/6 font-semibold text-gray-900">Log in <span aria-hidden="true">&rarr;</span></a>
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
                        <% if (isLoggedIn) { %>
                            <span class="-mx-3 block rounded-lg px-3 py-2.5 text-base/7 font-semibold text-gray-900"><%= userEmail %></span>
                            <a href="./logout" class="-mx-3 block rounded-lg px-3 py-2.5 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Log out</a>
                        <% } else { %>
                            <a href="./login" class="-mx-3 block rounded-lg px-3 py-2.5 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Log in</a>
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
                    <input type="text" id="search-token" placeholder="Search token by name or address..." 
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                </div>
                <select id="network-select" class="px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="base">Base</option>
                    <option value="eth">Ethereum</option>
                    <option value="arbitrum">Arbitrum</option>
                </select>
                <button onclick="searchToken()" class="px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-500">
                    Search
                </button>
            </div>
        </div>

        <!-- Main Trading Section -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div class="lg:col-span-2">
                <div class="bg-white rounded-lg shadow-lg overflow-hidden">
                    <div class="p-4 border-b border-gray-200">
                        <div class="flex items-center justify-between">
                            <div>
                                <h2 class="text-xl font-bold text-gray-900" id="token-name">Select a token to view chart</h2>
                                <p class="text-sm text-gray-600" id="token-price">-</p>
                            </div>
                        </div>
                    </div>
                    <!-- Embedded Chart Container -->
                    <div id="chart-container" class="relative" style="height: 600px;">
                        <div class="flex items-center justify-center h-full text-gray-500">
                            <div class="text-center">
                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                </svg>
                                <p class="mt-4 text-sm">Search for a token to display trading chart</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pool Information -->
                <div class="mt-6 bg-white rounded-lg shadow-lg p-6" id="pool-info" style="display: none;">
                    <h3 class="text-lg font-bold text-gray-900 mb-4">Pool Information</h3>
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <div>
                            <p class="text-sm text-gray-600">24h Volume</p>
                            <p class="text-lg font-semibold text-gray-900" id="pool-volume">-</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">Liquidity</p>
                            <p class="text-lg font-semibold text-gray-900" id="pool-liquidity">-</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">24h Txns</p>
                            <p class="text-lg font-semibold text-gray-900" id="pool-txns">-</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-600">Price Change</p>
                            <p class="text-lg font-semibold" id="pool-change">-</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Trading Panel (1/3 width) -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-lg shadow-lg p-6 sticky top-24">
                    <h3 class="text-lg font-bold mb-4">Buy with Any Token</h3>
                    <p class="text-sm text-gray-600 mb-6">
                        Use B3 AnySpend to buy with any token on any chain - automatically routed and swapped
                    </p>
                    
                    <!-- B3 AnySpend Button Container -->
                    <div id="b3-buy-container" class="mb-6">
                        <p class="text-center text-gray-500">Select a token to trade</p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script type="module" src="js/wallet.bundle.js"></script>
    <script type="module" src="js/dex.bundle.js"></script>
    <script src="js/dex.js"></script>
</body>
</html>
