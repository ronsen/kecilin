<script module>
	export { default as layout } from "./Layouts/App.svelte";
</script>

<script>
	import { page } from "@inertiajs/svelte";
	
	let { url } = $props();

	console.log(url);
	
</script>

<svelte:head>
	<title>{$page.props.appName}</title>
</svelte:head>

<img src={url} alt="Image" class="w-full"> 