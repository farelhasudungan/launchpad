<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Launchpad</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/output.css" rel="stylesheet">
</head>
<body class="bg-white text-black overflow-x-hidden font-[Poppins]">
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
        <div class="hidden lg:flex lg:flex-1 lg:justify-end">
            <a href="./login" class="text-sm/6 font-semibold text-gray-900">Log in <span aria-hidden="true">&rarr;</span></a>
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
                    <a href="./login" class="-mx-3 block rounded-lg px-3 py-2.5 text-base/7 font-semibold text-gray-900 hover:bg-gray-50">Log in</a>
                    </div>
                </div>
                </div>
            </el-dialog-panel>
            </div>
        </dialog>
        </el-dialog>
    </header>
    <div aria-hidden="true" class="fixed inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80">
        <div style="clip-path: polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)" 
             class="relative left-[calc(50%-11rem)] aspect-1155/678 w-144.5 -translate-x-1/2 rotate-30 bg-linear-to-tr from-[#60a5fa] to-[#3b82f6] opacity-30 sm:left-[calc(50%-30rem)] sm:w-288.75"></div>
    </div>
    <div aria-hidden="true" class="fixed inset-x-0 bottom-0 -z-10 transform-gpu overflow-hidden blur-3xl">
        <div style="clip-path: polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)" 
             class="relative left-[calc(50%+3rem)] aspect-1155/678 w-144.5 -translate-x-1/2 bg-linear-to-tr from-[#06b6d4] to-[#0ea5e9] opacity-25 sm:left-[calc(50%+36rem)] sm:w-288.75"></div>
    </div>
    <div class="w-full h-full relative inline-flex flex-col justify-start items-center">
        <div class="w-screen min-h-screen inline-flex justify-center items-center">
            <div class="px-22 py-32 inline-flex flex-col justify-start items-center">
            <div class="text-center justify-center"><span class="text-black text-9xl font-normal leading-40">We Build </span><span class="text-black text-9xl font-bold leading-40">Your Dream</span><span class="text-black text-9xl font-normal leading-40"> Crypto<br/>Project</span></div>
            </div>
        </div>

        <div class="w-screen bg-white px-10 py-32 flex flex-col justify-start items-start gap-2">
            <div class="self-stretch inline-flex flex-col justify-start items-center">
            <div class="justify-center text-black text-8xl font-normal leading-24">Our Story</div>
            </div>
            <div class="self-stretch pt-16 inline-flex justify-center items-start gap-20">
            <div class="w-[560px] self-stretch inline-flex flex-col justify-start items-start">
                <div class="self-stretch flex flex-col justify-start items-start">
                <div class="self-stretch justify-center text-gray-700 text-sm font-normal leading-6">We understand that every coin idea deserves a fair shot at success. Crypad is here to make launching your token as simple as a single click. From connecting your wallet to deploying your coin on the blockchain, our platform removes all technical barriers—no coding required, no liquidity pools to manage, and no complex smart contracts to write.</div>
                </div>
            </div>
            <div class="w-[560px] self-stretch inline-flex flex-col justify-start items-start">
                <div class="self-stretch flex flex-col justify-start items-start">
                <div class="self-stretch justify-center text-gray-700 text-sm font-normal leading-6">With built-in bonding curve mechanics, instant liquidity, and automated price discovery, your coin becomes tradable the moment it launches. Whether you're launching a community token, we provide fair-launch mechanics that give everyone equal access from day one.</div>
                </div>
            </div>
            </div>
        </div>

        <div class="self-stretch px-80 py-24 bg-gray-100 inline-flex flex-col justify-start items-center">
            <div class="w-full max-w-7xl inline-flex justify-center items-start gap-16">
                <div class="w-96 self-stretch inline-flex flex-col justify-start items-start gap-2">
                <div class="self-stretch flex flex-col justify-start items-center">
                    <div class="self-stretch text-center justify-center text-black text-9xl font-normal leading-32">280+</div>
                </div>
                <div class="self-stretch opacity-60 flex flex-col justify-start items-center">
                    <div class="self-stretch text-center justify-center text-black text-xs font-normal uppercase leading-4 tracking-wider">Coins Launched</div>
                </div>
                </div>
                <div class="w-96 self-stretch inline-flex flex-col justify-start items-start gap-2">
                <div class="self-stretch flex flex-col justify-start items-center">
                    <div class="self-stretch text-center justify-center text-black text-9xl font-normal leading-32">99+</div>
                </div>
                <div class="self-stretch opacity-60 flex flex-col justify-start items-center">
                    <div class="self-stretch text-center justify-center text-black text-xs font-normal uppercase leading-4 tracking-wider">Awesome Trader</div>
                </div>
                </div>
                <div class="w-96 self-stretch inline-flex flex-col justify-start items-start gap-2">
                <div class="self-stretch flex flex-col justify-start items-center">
                    <div class="self-stretch text-center justify-center text-black text-9xl font-normal leading-32">74+</div>
                </div>
                <div class="self-stretch opacity-60 flex flex-col justify-start items-center">
                    <div class="self-stretch text-center justify-center text-black text-xs font-normal uppercase leading-4 tracking-wider">Bounded</div>
                </div>
                </div>
            </div>
        </div>

        <div class="self-stretch h-[960px] bg-black inline-flex justify-center items-center">
            <div class="inline-flex flex-col justify-start items-center gap-10">
                <div class="flex flex-col justify-start items-center">
                <div class="text-center justify-center text-white text-8xl font-normal leading-[120px]">Explore more<br/>about us</div>
                </div>
                <div class="w-20 h-20 bg-white rounded-full inline-flex justify-center items-center">
                <div data-variant="1" class="w-6 h-6 relative">
                    <div class="w-2.5 h-3.5 left-2 top-[5px] absolute bg-black"></div>
                </div>
                </div>
            </div>
        </div>

        <div class="w-full bg-white px-4 md:px-10 py-16 md:py-32 mx-auto flex flex-col justify-start items-center gap-8 md:gap-16">
            <div class="text-black text-4xl md:text-6xl lg:text-8xl font-normal leading-tight">Our Steps</div>
            <div class="w-full grid max-w-7xl grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 md:gap-12">
                <div class="border-t border-gray-300 pt-10">
                    <div class="opacity-40 text-black text-xs font-normal leading-4 mb-5">01</div>
                    <div class="text-black text-xl md:text-2xl font-normal leading-8 mb-4">Connect & Create</div>
                    <div class="opacity-70 text-black text-sm font-normal leading-6">
                        Connect your wallet and click "Create Coin" to begin. Choose your token name, ticker symbol, and upload an eye-catching image that represents your coin.​
                    </div>
                </div>
                
                <div class="border-t border-gray-300 pt-10">
                    <div class="opacity-40 text-black text-xs font-normal leading-4 mb-5">02</div>
                    <div class="text-black text-xl md:text-2xl font-normal leading-8 mb-4">Design Your Token</div>
                    <div class="opacity-70 text-black text-sm font-normal leading-6">
                        Add a compelling description and link your social media accounts to build credibility. Set your initial parameters and bonding curve settings to determine how your coin's price will grow.
                    </div>
                </div>

                <div class="border-t border-gray-300 pt-10">
                    <div class="opacity-40 text-black text-xs font-normal leading-4 mb-5">03</div>
                    <div class="text-black text-xl md:text-2xl font-normal leading-8 mb-4">Launch on Bonding Curve</div>
                    <div class="opacity-70 text-black text-sm font-normal leading-6">
                        Deploy your coin instantly with a small creation fee. Your token goes live on the bonding curve, where price automatically adjusts based on real-time supply and demand.
                    </div>
                </div>
                
                <div class="border-t border-gray-300 pt-10">
                    <div class="opacity-40 text-black text-xs font-normal leading-4 mb-5">04</div>
                    <div class="text-black text-xl md:text-2xl font-normal leading-8 mb-4">Build Momentum</div>
                    <div class="opacity-70 text-black text-sm font-normal leading-6">
                        Watch as early supporters buy in and the price climbs along the curve. Monitor real-time holder distribution, trade activity, and community engagement through your token dashboard.
                    </div>
                </div>
                
                <div class="border-t border-gray-300 pt-10">
                    <div class="opacity-40 text-black text-xs font-normal leading-4 mb-5">05</div>
                    <div class="text-black text-xl md:text-2xl font-normal leading-8 mb-4">Graduate to DEX</div>
                    <div class="opacity-70 text-black text-sm font-normal leading-6">
                        Once your coin reaches the bonding curve target, liquidity automatically migrates to the decentralized exchange. Your coin becomes fully tradable with locked liquidity for security.
                    </div>
                </div>
                
                <div class="border-t border-gray-300 pt-10">
                    <div class="opacity-40 text-black text-xs font-normal leading-4 mb-5">06</div>
                    <div class="text-black text-xl md:text-2xl font-normal leading-8 mb-4">Grow Your Community</div>
                    <div class="opacity-70 text-black text-sm font-normal leading-6">
                        Celebrate your successful launch and continue engaging with your holders.
                    </div>
                </div>
            </div>
        </div>

        <div class="w-full px-4 md:px-10 py-16 md:py-32 bg-gray-50 flex flex-col justify-start items-center gap-12 md:gap-20">
            <div class="text-center text-black text-4xl md:text-6xl lg:text-8xl font-normal leading-tight md:leading-[120px]">
                Meet The<br/>Amazing Team
            </div>
            <div class="w-full max-w-7xl grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8 md:gap-10">
                <div class="relative overflow-hidden aspect-3/4 group">
                    <img class="w-full h-full object-cover grayscale hover:grayscale-0 transition-all duration-300" 
                        src="#" 
                        alt="Farrel Hasudungan I. L." />
                    <div class="absolute bottom-0 left-0 right-0 p-6 md:p-8 bg-linear-to-t from-black/80 to-transparent">
                        <div class="text-white text-xl md:text-2xl font-normal leading-8 mb-1">Farrel Hasudungan I. L.</div>
                        <div class="text-white text-xs opacity-80 leading-5">Chief Executive Officer</div>
                    </div>
                </div>
                
                <div class="relative overflow-hidden aspect-3/4 group">
                    <img class="w-full h-full object-cover grayscale hover:grayscale-0 transition-all duration-300" 
                        src="#" 
                        alt="M. Nabil Fauzan" />
                    <div class="absolute bottom-0 left-0 right-0 p-6 md:p-8 bg-linear-to-t from-black/80 to-transparent">
                        <div class="text-white text-xl md:text-2xl font-normal leading-8 mb-1">M. Nabil Fauzan</div>
                        <div class="text-white text-xs opacity-80 leading-5">Chief Technology Officer</div>
                    </div>
                </div>
                
                <div class="relative overflow-hidden aspect-3/4 group">
                    <img class="w-full h-full object-cover grayscale hover:grayscale-0 transition-all duration-300" 
                        src="#" 
                        alt="Acquirell Kriswanto" />
                    <div class="absolute bottom-0 left-0 right-0 p-6 md:p-8 bg-linear-to-t from-black/80 to-transparent">
                        <div class="text-white text-xl md:text-2xl font-normal leading-8 mb-1">Acquirell Kriswanto</div>
                        <div class="text-white text-xs opacity-80 leading-5">Head of Marketing</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="self-stretch h-[840px] bg-black/50 inline-flex justify-center items-center">
            <div class="px-5 inline-flex flex-col justify-start items-center">
                <div class="text-center justify-center text-white text-8xl font-normal leading-[120px]">Find your</div>
                <div class="text-center justify-center text-white text-8xl font-bold leading-[120px]">Dream Project</div>
                <div class="text-center justify-center text-white text-8xl font-normal leading-[120px]">Faster</div>
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
    </div>
</body>
</html>
