<script module>
	export { default as layout } from "./Layouts/App.svelte";
</script>

<script>
	import { page } from "@inertiajs/svelte";
</script>

<svelte:head>
	<title>{$page.props.appName}</title>
</svelte:head>

<p>File was successfully deleted from server.</p>