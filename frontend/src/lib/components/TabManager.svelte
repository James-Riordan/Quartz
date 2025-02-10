<script lang="ts">
    import { browser } from '$app/environment';
    import { writable } from 'svelte/store';
  
    let isTabManagerVisible = writable(false);
  
    function handleMouseMove(event: MouseEvent) {
      if (!browser) return;
      isTabManagerVisible.set(event.clientY < 20);
    }
  
    if (browser) {
      window.addEventListener('mousemove', handleMouseMove);
    }
  </script>
  
  <div
    class="fixed top-0 left-0 right-0 bg-gray-900 text-white flex space-x-4 p-2 transition-transform duration-300"
    style="transform: translateY({$isTabManagerVisible ? '0px' : '-50px'})"
  >
    <button class="bg-gray-700 px-4 py-1 rounded">File 1</button>
    <button class="bg-gray-700 px-4 py-1 rounded">File 2</button>
    <button class="bg-gray-700 px-4 py-1 rounded">+</button>
  </div>
  