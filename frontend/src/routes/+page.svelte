<script lang="ts">
	import { writable } from 'svelte/store';
	import { browser } from '$app/environment';
	import FileSidebar from '$lib/components/Sidebars/FileSidebar.svelte';
	import ButtonSidebar from '$lib/components/Sidebars/ButtonSidebar.svelte';
	import TabManager from '$lib/components/TabManager.svelte';
	import PWD from '$lib/components/PWD.svelte';
	import MainEditor from '$lib/components/MainEditor.svelte';

	// Sidebar state
	var isLeftSidebarVisible = $state(false);
	var isButtonSidebarVisible = $state(false);
	var isSidebarPinned = $state(false);
	var isSmartSidebarEnabled = $state(true);

	// Opacity states for smooth transitions
	var sidebarOpacity = $state(0);
	var textOpacity = $state(0.2);
	const maxDistance = 60;

	function updateSidebarVisibility(event: MouseEvent) {
		if (!browser || !isSmartSidebarEnabled) return;
		const sidebar = document.getElementById('sidebar');
		if (!sidebar) return;

		const { left, right } = sidebar.getBoundingClientRect();
		const distanceToSidebar = Math.max(0, event.clientX - right);
		const proximity = Math.max(0, Math.min(1, 1 - distanceToSidebar / maxDistance));

		if (isSidebarPinned) {
			sidebarOpacity = 1;
			textOpacity = 1;
		} else {
			sidebarOpacity = proximity;
			textOpacity = 0.2 + proximity * 0.8;
		}
	}

	function toggleSidebar() {
		isSidebarPinned = !isSidebarPinned;
		sidebarOpacity = isSidebarPinned ? 1 : 0;
		textOpacity = isSidebarPinned ? 1 : 0.2;
	}

	// Event listeners for sidebar behavior
	if (browser) {
		window.addEventListener('mousemove', updateSidebarVisibility);
		window.addEventListener('keydown', (event) => {
			if (event.altKey && event.key === 'b') {
				toggleSidebar();
			}
		});
	}
</script>

<div class="flex flex-col h-screen w-screen">
	<TabManager />
	<PWD />
	<div class="flex w-full h-full">
		<ButtonSidebar bind:isButtonSidebarVisible />
		<FileSidebar 
			sidebarOpacity={sidebarOpacity}
			textOpacity={textOpacity}
			isLeftSidebarVisible={isLeftSidebarVisible}
			isButtonSidebarVisible={isButtonSidebarVisible}
		/>
		<MainEditor />
		
	</div>
</div>
