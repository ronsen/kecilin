<script module>
	export { default as layout } from "./Layouts/App.svelte";
</script>

<script>
	import { page, Link } from "@inertiajs/svelte";
	import { Download } from "lucide-svelte";

	let { file, url } = $props();
</script>

<svelte:head>
	<title>{$page.props.appName}</title>
</svelte:head>

<div class="mb-4">
	<img src={url} alt="[]" class="w-full" />
</div>

<div class="flex justify-center mb-4">
	<a
		href={url}
		class="bg-blue-500 hover:bg-blue-600 text-white w-full px-3 py-2 rounded-full flex justify-center items-center"
		download><Download size={16} /><span class="ml-1">Download</span></a
	>
</div>

<div class="flex justify-center">
	<Link
		href="/delete?file={file}"
		class="bg-red-500 hover:bg-red-600 text-white w-full px-3 py-2 rounded-full text-center"
		>Delete file from server</Link
	>
</div>
