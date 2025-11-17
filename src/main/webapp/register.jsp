<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Launchpad</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="css/output.css" rel="stylesheet">
</head>
<body class="bg-white min-h-screen flex items-center justify-center p-4 relative overflow-x-hidden overflow-y-auto font-[Poppins]">
    <div aria-hidden="true" class="fixed inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80">
        <div style="clip-path: polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)" 
             class="relative left-[calc(50%-11rem)] aspect-1155/678 w-144.5 -translate-x-1/2 rotate-30 bg-linear-to-tr from-[#60a5fa] to-[#3b82f6] opacity-30 sm:left-[calc(50%-30rem)] sm:w-288.75"></div>
    </div>
    <div aria-hidden="true" class="fixed inset-x-0 bottom-0 -z-10 transform-gpu overflow-hidden blur-3xl">
        <div style="clip-path: polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)" 
             class="relative left-[calc(50%+3rem)] aspect-1155/678 w-144.5 -translate-x-1/2 bg-linear-to-tr from-[#06b6d4] to-[#0ea5e9] opacity-25 sm:left-[calc(50%+36rem)] sm:w-288.75"></div>
    </div>
    <section class="relative w-full">
        <div class="py-20 md:py-28 flex items-center">
            <div class="container px-4 mx-auto">
                <div class="max-w-md mx-auto">
                    <div class="bg-white rounded-lg shadow-lg p-9 md:p-10">
                        <div class="mb-11 text-left">
                            <span class="text-lg font-medium text-black">Welcome newcomer!</span>
                            <p class="text-sm text-gray-500 font-medium">You are early! Make your project bigger with Us now!</p>
                        </div>
                        <form action="register" method="POST">
                            <div class="mb-6">
                                <label class="block mb-2 text-gray-800 font-medium" for="name">Full Name</label>
                                <input class="w-full py-3 px-4 text-gray-500 leading-tight placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-white focus:ring-opacity-50 border border-gray-200 rounded-lg shadow-xs" type="text" name="name" placeholder="John Doe" required=""/>
                            </div>
                            <div class="mb-6">
                                <label class="block mb-2 text-gray-800 font-medium" for="dob">Date of Birth</label>
                                <input class="w-full py-3 px-4 text-gray-500 leading-tight placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-white focus:ring-opacity-50 border border-gray-200 rounded-lg shadow-xs" type="date" name="dob" required=""/>
                            </div>
                            <div class="mb-6">
                                <label class="block mb-2 text-gray-800 font-medium" for="email">Email Address</label>
                                <input class="w-full py-3 px-4 text-gray-500 leading-tight placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-white focus:ring-opacity-50 border border-gray-200 rounded-lg shadow-xs" type="email" name="email" placeholder="you@example.com" required=""/>
                            </div>
                            <div class="mb-6">
                                <label class="block mb-2 text-gray-800 font-medium" for="password">Password</label>
                                <input class="w-full py-3 px-4 text-gray-500 leading-tight placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-white focus:ring-opacity-50 border border-gray-200 rounded-lg shadow-xs" type="password" name="password" placeholder="Enter your password" required=""/>
                            </div>
                            <div class="mb-6">
                                <label class="block mb-2 text-gray-800 font-medium" for="confirm-password">Confirm Password</label>
                                <input class="w-full py-3 px-4 text-gray-500 leading-tight placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-white focus:ring-opacity-50 border border-gray-200 rounded-lg shadow-xs" type="password" name="confirm-password" placeholder="Enter your password again" required=""/>
                            </div>
                            <div class="mb-6 flex items-center">
                                <label>
                                    <input type="checkbox" name="tnc" value="1" required=""/>
                                    <span class="ml-1 text-gray-800 text-sm">I agree to the <a class="text-black hover:text-gray-800 font-medium" href="#">Terms and Conditions</a></span>
                                </label>
                            </div>
                            <button class="inline-block py-3 px-7 w-full text-lg leading-7 text-white bg-black hover:bg-gray-900 font-medium text-center focus:ring-2 focus:ring-white focus:ring-opacity-50 border border-transparent rounded-full" type="submit">Sign Up</button>
                        </form>
                        <div class="mt-6 text-center">
                            <p class="text-gray-500">Already have an account? <a class="text-black hover:text-gray-800 font-medium" href="./login">Sign in</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
