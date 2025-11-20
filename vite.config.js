import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  build: {
    outDir: 'src/main/webapp/js',
    emptyOutDir: false,
    rollupOptions: {
      input: {
        wallet: resolve(__dirname, 'src/main/webapp/js/wallet.js')
      },
      output: {
        publicPath: '/js/',
        entryFileNames: '[name].bundle.js',
        chunkFileNames: '[name].chunk.js',
        assetFileNames: '[name].[ext]'
      }
    }
  },
  base: '/js/',
  resolve: {
    alias: {
      process: "process/browser",
      stream: "stream-browserify",
      util: "util"
    }
  }
});
