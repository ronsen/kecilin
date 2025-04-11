<script module>
	export { default as layout } from "./Layouts/App.svelte";
</script>

<script>
	import { page } from "@inertiajs/svelte";

	let { url } = $props();
</script>

<svelte:head>
	<title>{$page.props.appName}</title>
</svelte:head>

<div class="mb-4">
	<img src={url} alt="[]" class="w-full" />
</div>

<div class="flex justify-center">
	<a
		href={url}
		class="bg-blue-500 hover:bg-blue-600 text-white w-full px-3 py-2 rounded-full text-center"
		download>Download</a
	>
</div>

