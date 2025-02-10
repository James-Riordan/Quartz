<script lang="ts">
    import { browser } from '$app/environment';
    import { writable } from 'svelte/store';
  
    export let currentPath = writable('path/to/file.svx');
    let isPWDVisible = writable(false);
  
    function handleMouseMove(event: MouseEvent) {
      if (!browser) return;
      isPWDVisible.set(event.clientY < 50);
    }
  
    if (browser) {
      window.addEventListener('mousemove', handleMouseMove);
    }
  </script>
  
  <div
    class="fixed top-0 left-0 right-0 bg-gray-800 text-white text-sm p-2 transition-transform duration-300"
    style="transform: translateY({$isPWDVisible ? '0px' : '-50px'})"
  >
    {$currentPath}
  </div>