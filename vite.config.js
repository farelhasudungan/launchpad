import { defineConfig } from 'vite';
import { resolve } from 'path';

export default defineConfig({
  build: {
    outDir: 'src/main/webapp/js',
    rollupOptions: {
      input: {
        wallet: resolve(__dirname, 'src/main/webapp/js/wallet.js')
      },
      output: {
        entryFileNames: '[name].bundle.js',
        chunkFileNames: '[name].chunk.js',
        assetFileNames: '[name].[ext]'
      }
    }
  },
  resolve: {
    alias: {
      process: "process/browser",
      stream: "stream-browserify",
      util: "util"
    }
  }
});
