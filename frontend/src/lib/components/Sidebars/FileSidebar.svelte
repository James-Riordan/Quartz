<script lang="ts">
	let { sidebarOpacity, textOpacity, isLeftSidebarVisible, isButtonSidebarVisible } = $props();

	let selectedVault = $state('Default Vault');
	let vaults = ['Default Vault', 'Personal', 'Work', 'Projects'];

	function openSettings() {
		alert('Open settings menu (Replace this with actual logic)');
	}
</script>

<div
	id="sidebar"
	class="flex h-full w-48 flex-col justify-between bg-transparent transition-transform duration-300 border-black border-r"
	style="opacity: {sidebarOpacity}; transform: translateX({isLeftSidebarVisible ? '20px' : isButtonSidebarVisible ? '50px' : '0px'})"
>
	<!-- Sidebar Content -->
	<div class="mt-4 space-y-2">
		{#each ['📂 Documents', '📄 Notes.svx', '📄 Tasks.svx', '📂 Projects', '📄 Roadmap.svx'] as item}
			<div class="cursor-pointer pl-4 transition-opacity duration-300" style="opacity: {textOpacity}">
				{item}
			</div>
		{/each}
	</div>

	<!-- Bottom Section -->
	<div class="flex items-center justify-between border-t border-gray-700 pb-3 pl-3 pt-3">
		<select
			bind:value={selectedVault}
			class="cursor-pointer border-none bg-transparent text-sm text-black outline-none dark:text-white"
			style="opacity: {textOpacity}"
		>
			{#each vaults as vault}
				<option value={vault} class="bg-gray-800">{vault}</option>
			{/each}
		</select>

		<button onclick={openSettings} class="rounded p-2 transition-opacity duration-300 hover:bg-gray-700">
			⚙️
		</button>
	</div>
</div>
