<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/state';
	import { browser } from '$app/environment';
	import { writable } from 'svelte/store';

	let content = writable('');

	onMount(async () => {
		if (!browser) return;

		let slug = page.url.pathname.replace(/^\//, ''); // Extract the slug from URL

		// Dynamically import the .svx file based on the slug
		try {
			const module = await import(`../../routes/notes/${slug}/+page.svx`);
			if (module && module.default) {
				content.set(module.default.render().html);
			}
		} catch (error) {
			console.error('Failed to load content:', error);
			content.set('<p>File not found.</p>');
		}
	});
</script>

<div class="w-full">
	{@html $content}
</div>
