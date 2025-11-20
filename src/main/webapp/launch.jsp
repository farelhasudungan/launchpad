<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.launchpad.model.Token" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Launchpad</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/output.css" rel="stylesheet">
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
</head>
<body class="bg-white text-black font-[Poppins] overflow-x-hidden">
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

    <% if (request.getParameter("success") != null) { 
        String contractAddress = request.getParameter("contract");
    %>
        <div class="fixed top-20 right-4 bg-green-500 text-white px-6 py-4 rounded shadow-lg z-50">
            <div class="font-bold">Token Deployed Successfully! 🚀</div>
            <% if (contractAddress != null) { %>
                <div class="text-sm mt-2">
                    Contract: <a href="https://basescan.org/address/<%= contractAddress %>" 
                                target="_blank" 
                                class="underline"><%= contractAddress %></a>
                </div>
            <% } %>
        </div>
    <% } %>

    
    <% if (request.getAttribute("error") != null) { %>
        <div class="fixed top-20 right-4 bg-red-500 text-white px-6 py-4 rounded shadow-lg z-50">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <%
        List<Token> newestTokens = (List<Token>) request.getAttribute("newestTokens");
    %>
    
    <div class="px-4 md:px-10 lg:px-80 py-8 md:py-16 bg-gray-50 border-b border-gray-100">
        <div class="w-full max-w-7xl mx-auto flex flex-col gap-6 md:gap-8">
            <h2 class="text-xl md:text-2xl font-normal leading-9">Newest Tokens</h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                <% 
                if (newestTokens != null && !newestTokens.isEmpty()) {
                    for (Token token : newestTokens) { 
                %>
                    <div class="p-5 bg-white border border-gray-200 hover:border-black transition-all flex flex-col gap-3 cursor-pointer">
                        <div class="flex items-center gap-3">
                            <img 
                                src="<%= request.getContextPath() %>/token-image?id=<%= token.getId() %>" 
                                alt="<%= token.getSymbol() %>"
                                data-fallback="https://via.placeholder.com/40?text=<%= token.getSymbol() %>"
                                onerror="this.onerror=null; this.src=this.dataset.fallback;"
                                class="w-10 h-10 rounded-full object-cover shrink-0 border border-gray-200"
                            />
                            <div class="flex flex-col">
                                <div class="text-black text-sm font-medium leading-5"><%= token.getSymbol() %></div>
                                <div class="text-black text-xs font-normal leading-4 opacity-60"><%= token.getNetwork() %></div>
                            </div>
                        </div>
                    </div>
                <% 
                    }
                } else { 
                %>
                    <div class="col-span-full text-center py-8 text-gray-500">
                        No token available yet.
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <div class="w-full max-w-4xl mx-auto px-4 md:px-6 py-16 md:py-32" x-data="launchForm()">
        <div class="flex flex-col gap-8 md:gap-12">
            <div class="flex flex-col gap-3 md:gap-4">
                <h2 class="text-3xl md:text-4xl lg:text-5xl font-normal leading-tight">Create Your Token</h2>
                <p class="text-gray-600 text-sm md:text-base font-normal leading-relaxed">
                    Deploy to Base, Arbitrum, or Ethereum networks
                </p>
            </div>

            <form action="<%= request.getContextPath() %>/launch" method="post" enctype="multipart/form-data" class="flex flex-col gap-6 md:gap-8">
                <div class="flex flex-col gap-4" x-data="{ showArbitrumMsg: false, showEthereumMsg: false }">
                    <label class="text-black text-xs md:text-sm font-normal uppercase leading-5 tracking-wide opacity-60">Network</label>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-3 md:gap-4">
                        <button 
                            type="button" 
                            @click="network = 'base'"
                            :class="network === 'base' ? 'bg-black border-black text-white' : 'border-gray-300 text-black bg-white hover:border-black'"
                            class="px-4 py-3 md:py-4 border-2 text-sm md:text-base font-normal leading-6 transition-all"
                        >
                            Base
                        </button>
                        
                        <div class="relative">
                            <button 
                                type="button" 
                                @click="showArbitrumMsg = true; setTimeout(() => showArbitrumMsg = false, 3000)"
                                class="w-full px-4 py-3 md:py-4 border-2 border-gray-200 bg-gray-100 text-gray-400 text-sm md:text-base font-normal leading-6 cursor-not-allowed opacity-60 hover:opacity-80 transition-all"
                            >
                                Arbitrum
                            </button>
                            <span class="absolute -top-2 -right-2 bg-yellow-400 text-black text-xs px-2 py-1 rounded-full font-medium shadow-sm">
                                Coming Soon
                            </span>
                            <div 
                                x-show="showArbitrumMsg" 
                                x-transition
                                class="absolute top-full mt-2 left-0 right-0 bg-yellow-50 border border-yellow-300 text-yellow-800 text-xs px-3 py-2 rounded shadow-lg z-10"
                            >
                                ⚠️ Arbitrum network is coming soon! Currently only Base is supported.
                            </div>
                        </div>
                        
                        <div class="relative">
                            <button 
                                type="button" 
                                @click="showEthereumMsg = true; setTimeout(() => showEthereumMsg = false, 3000)"
                                class="w-full px-4 py-3 md:py-4 border-2 border-gray-200 bg-gray-100 text-gray-400 text-sm md:text-base font-normal leading-6 cursor-not-allowed opacity-60 hover:opacity-80 transition-all"
                            >
                                Ethereum
                            </button>
                            <span class="absolute -top-2 -right-2 bg-yellow-400 text-black text-xs px-2 py-1 rounded-full font-medium shadow-sm">
                                Coming Soon
                            </span>
                            <div 
                                x-show="showEthereumMsg" 
                                x-transition
                                class="absolute top-full mt-2 left-0 right-0 bg-yellow-50 border border-yellow-300 text-yellow-800 text-xs px-3 py-2 rounded shadow-lg z-10"
                            >
                                ⚠️ Ethereum network is coming soon! Currently only Base is supported.
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="network" :value="network"/>
                </div>


                <!-- Token Name -->
                <div class="flex flex-col gap-3">
                    <label class="text-black text-xs md:text-sm font-normal uppercase leading-5 tracking-wide opacity-60">Token Name</label>
                    <input 
                        type="text" 
                        name="tokenName"
                        x-model="tokenName"
                        placeholder="Enter your token name"
                        required
                        class="px-4 py-4 md:py-5 bg-white border border-gray-300 focus:border-black focus:outline-none text-sm md:text-base font-normal transition-all"
                    />
                </div>

                <!-- Token Symbol -->
                <div class="flex flex-col gap-3">
                    <label class="text-black text-xs md:text-sm font-normal uppercase leading-5 tracking-wide opacity-60">Symbol</label>
                    <input 
                        type="text" 
                        name="symbol"
                        x-model="symbol"
                        placeholder="e.g., BTC, ETH"
                        maxlength="6"
                        required
                        class="px-4 py-4 md:py-5 bg-white border border-gray-300 focus:border-black focus:outline-none text-base md:text-lg font-normal uppercase transition-all"
                    />
                </div>

                <!-- Token Image -->
                <div class="flex flex-col gap-3">
                    <label class="text-black text-xs md:text-sm font-normal uppercase leading-5 tracking-wide opacity-60">Token Image</label>
                    <div class="p-8 md:p-12 border-2 border-dashed border-gray-300 hover:border-black transition-all">
                        <input 
                            type="file" 
                            id="tokenImage"
                            name="tokenImage" 
                            @change="handleImageUpload($event)"
                            accept="image/jpeg,image/png" 
                            class="hidden" 
                        />
                        <label for="tokenImage" class="flex flex-col items-center gap-2 md:gap-3 cursor-pointer">
                            <div class="text-3xl md:text-4xl">📁</div>
                            <div class="text-black text-sm md:text-base font-normal leading-5" x-text="imageName || 'Select file (JPEG / PNG, 1MB max)'"></div>
                            <div class="text-black text-xs font-normal leading-4 opacity-60">or drag and drop</div>
                        </label>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="pt-6 md:pt-8 border-t border-gray-200">
                    <button 
                        type="submit"
                        class="w-full px-6 md:px-8 py-4 md:py-5 bg-black text-white text-base md:text-lg font-normal uppercase leading-7 tracking-wide hover:bg-gray-800 transition-all disabled:opacity-50"
                        :disabled="!isFormValid()"
                    >
                        Deploy Token
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function launchForm() {
            return {
                network: 'base',
                tokenName: '',
                symbol: '',
                imageName: '',

                handleImageUpload(event) {
                    const file = event.target.files[0];
                    if (file) {
                        this.imageName = file.name;
                    }
                },

                isFormValid() {
                    return this.network && this.tokenName && this.symbol;
                }
            }
        }
    </script>

    <div class="px-4 md:px-10 lg:px-80 py-12 md:py-20 bg-gray-50">
        <div class="w-full max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8 md:gap-12">
            <div class="flex flex-col gap-4 md:gap-0">
                <div class="text-black text-5xl md:text-6xl font-normal leading-tight md:leading-[60px] mb-3 md:mb-4">01</div>
                <h3 class="text-black text-base md:text-lg font-normal leading-7 mb-2 md:mb-3">Simple Setup</h3>
                <p class="text-black text-xs font-normal leading-6 opacity-70">
                    Fill in your token details and deploy in minutes. No coding required.
                </p>
            </div>
            
            <div class="flex flex-col gap-4 md:gap-0">
                <div class="text-black text-5xl md:text-6xl font-normal leading-tight md:leading-[60px] mb-3 md:mb-4">02</div>
                <h3 class="text-black text-base md:text-lg font-normal leading-7 mb-2 md:mb-3">Multi-Chain</h3>
                <p class="text-black text-xs font-normal leading-6 opacity-70">
                    Deploy to Base, Arbitrum, or Ethereum networks seamlessly.
                </p>
            </div>
            
            <div class="flex flex-col gap-4 md:gap-0">
                <div class="text-black text-5xl md:text-6xl font-normal leading-tight md:leading-[60px] mb-3 md:mb-4">03</div>
                <h3 class="text-black text-base md:text-lg font-normal leading-7 mb-2 md:mb-3">Instant Launch</h3>
                <p class="text-black text-xs font-normal leading-6 opacity-70">
                    Your token goes live immediately with automatic liquidity pool creation.
                </p>
            </div>
        </div>
    </div>

    <div class="w-full px-4 md:px-8 py-8 md:py-12 bg-white border-t border-gray-200">
        <div class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 md:gap-12">  
            <div class="flex flex-col gap-3">
                <div class="text-black text-base font-semibold leading-6 pb-2">Explore</div>
                <a href="#" class="text-black text-sm md:text-base font-normal leading-6 hover:opacity-60">Launch</a>
                <a href="#" class="text-black text-sm md:text-base font-normal leading-6 hover:opacity-60">Buy</a>
                <a href="#" class="text-black text-sm md:text-base font-normal leading-6 hover:opacity-60">Sell</a>
            </div>
            
            <div class="flex flex-col gap-3">
                <div class="text-black text-base font-semibold leading-6 pb-2">Resources</div>
                <a href="./about-us" class="text-black text-sm md:text-base font-normal leading-6 hover:opacity-60">About Us</a>
                <a href="#" class="text-black text-sm md:text-base font-normal leading-6 hover:opacity-60">Terms and Conditions</a>
                <a href="#" class="text-black text-sm md:text-base font-normal leading-6 hover:opacity-60">Support</a>
                <a href="#" class="text-black text-sm md:text-base font-normal leading-6 hover:opacity-60">Developers</a>
            </div>
        </div>
    </div>

    <script type="module" src="js/wallet.bundle.js"></script>
</body>
</html>
