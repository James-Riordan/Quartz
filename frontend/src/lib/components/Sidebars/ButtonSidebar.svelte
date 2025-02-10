<script lang="ts">
	import { browser } from '$app/environment';

  let { isButtonSidebarVisible = $bindable() } = $props();

	function handleMouseMove(event: MouseEvent) {
		if (!browser) return;
		isButtonSidebarVisible = event.clientX < 50;
	}
	
	if (browser) {
		window.addEventListener("mousemove", handleMouseMove);
	}
</script>

<div
	class="fixed top-0 left-0 h-full w-12 bg-gray-900 text-white flex flex-col items-center justify-start space-y-4 pt-4 transition-transform duration-300"
	style="transform: translateX({isButtonSidebarVisible ? '0px' : '-50px'})"
>
	<!-- Excalidraw -->
	<button class="p-2 hover:bg-gray-700 rounded">🎨</button>

	<!-- Canvas -->
	<button class="p-2 hover:bg-gray-700 rounded">📜</button>

	<!-- Quick Switcher -->
	<button class="p-2 hover:bg-gray-700 rounded">🔍</button>
</div>
