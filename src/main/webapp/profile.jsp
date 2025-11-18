<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.launchpad.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) { response.sendRedirect("profile"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/output.css" rel="stylesheet">
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
        <div class="hidden lg:flex lg:flex-1 lg:justify-end items-center gap-4">
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
                        <% if (isLoggedIn) { 
                            // Logic nama untuk avatar (sama seperti desktop)
                            String displayName = (userEmail != null) ? userEmail : "User";
                        %>
                            <div class="relative -mx-3 mb-2 border-t border-gray-100 pt-4">
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
                                        <span class="text-xs font-medium text-gray-500 mt-0.5">
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

    <div class="w-full max-w-3xl mx-auto px-4 md:px-6 py-16 md:py-24">
        <div class="flex flex-col gap-8">
            <div class="flex items-center gap-6 pb-8 border-b border-gray-200">
                <img 
                    src="https://ui-avatars.com/api/?name=<%= user.getName() %>&background=000&color=fff&rounded=true&size=96" 
                    alt="Profile" 
                    class="w-24 h-24 rounded-full border-4 border-gray-100 shadow-lg object-cover shrink-0"
                />
                <div>
                    <h1 class="text-3xl font-semibold text-black"><%= user.getName() %></h1>
                    <p class="text-gray-500"><%= user.getEmail() %></p>
                </div>
            </div>

            <% if (request.getAttribute("success") != null) { %>
                <div class="p-4 bg-green-50 border border-green-200 text-green-700 rounded-lg">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="p-4 bg-red-50 border border-red-200 text-red-700 rounded-lg">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="profile" method="post" class="flex flex-col gap-6">
                
                <div class="flex flex-col gap-2">
                    <label class="text-sm font-medium text-gray-700">Full Name</label>
                    <input 
                        type="text" 
                        name="name" 
                        value="<%= user.getName() %>" 
                        required
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent transition-all"
                    />
                </div>

                <div class="flex flex-col gap-2">
                    <label class="text-sm font-medium text-gray-700">Date of Birth</label>
                    <input 
                        type="date" 
                        name="dob" 
                        value="<%= (user.getDob() != null) ? user.getDob() : "" %>"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent transition-all"
                    />
                </div>

                <div class="flex flex-col gap-2">
                    <label class="text-sm font-medium text-gray-700">Social Media Link (X / Instagram)</label>
                    <input 
                        type="url" 
                        name="socialLink" 
                        value="<%= (user.getSocialLink() != null) ? user.getSocialLink() : "" %>"
                        placeholder="https://x.com/username"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent transition-all"
                    />
                </div>

                <div class="pt-4">
                    <button 
                        type="submit"
                        class="px-16 py-4 bg-black text-white font-medium rounded-full hover:bg-gray-800 transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
                    >
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>