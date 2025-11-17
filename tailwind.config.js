/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/main/webapp/*.jsp",
    "./src/main/webapp/*.html",
  ],
  theme: {
    extend: {
      fontFamily: {
        'sans': ['Poppins', 'sans-serif'],
        'poppins': ['Poppins', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
