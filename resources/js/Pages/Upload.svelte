<script module>
	export { default as layout } from "./Layouts/App.svelte";
</script>

<script>
	import { page, Link, useForm } from "@inertiajs/svelte";
	import { Download } from "lucide-svelte";

	let { file, url, fileName, fileSize, mimeType, height, width } = $props();

	let dialog;

	const form = useForm({
		file,
	});

	function submit(e) {
		e.preventDefault();
		$form.delete("/delete");
	}
</script>

<svelte:head>
	<title>{$page.props.appName}</title>
</svelte:head>

<div class="mb-4">
	<img src={url} alt="[]" class="w-full" />

	{#if fileName}
		<table class="w-full mt-4">
			<tbody>
				<tr class="border-b">
					<td class="py-2">File Name:</td>
					<td class="py-2 font-bold">{fileName}</td>
				</tr>
				<tr class="border-b">
					<td class="py-2">File Size:</td>
					<td class="py-2 font-bold">{fileSize} bytes</td>
				</tr>
				<tr class="border-b">
					<td class="py-2">Mime Type:</td>
					<td class="py-2 font-bold">{mimeType}</td>
				</tr>
				<tr class="border-b">
					<td class="py-2">Height:</td>
					<td class="py-2 font-bold">{height} px</td>
				</tr>
				<tr class="border-b">
					<td class="py-2">Width:</td>
					<td class="py-2 font-bold">{width} px</td>
				</tr>
			</tbody>
		</table>
	{/if}
</div>

<div class="flex justify-center mb-4">
	<a
		href={url}
		class="bg-blue-500 hover:bg-blue-600 text-white w-full px-3 py-2 rounded-full flex justify-center items-center"
		download><Download size={16} /><span class="ml-1">Download</span></a
	>
</div>

<div class="flex justify-center">
	<button
		onclick={() => dialog.show()}
		class="bg-red-500 hover:bg-red-600 text-white w-full px-3 py-2 rounded-full cursor-pointer"
		>Delete file from server</button
	>

	<dialog
		bind:this={dialog}
		class="fixed top-0 left-0 translate-y-1/2 w-1/4 m-auto rounded-lg bg-zinc-50 text-black/90 antialiased dark:bg-zinc-900 dark:text-white/90 p-6 border"
	>
		<form onsubmit={submit}>
			<p>Are you sure want to delete this file?</p>
			<div class="mt-6 flex justify-content-between gap-4">
				<button
					type="button"
					onclick={() => dialog.close()}
					class="bg-blue-500 hover:bg-blue-600 text-white w-full px-3 py-2 rounded-full"
					>No</button
				>
				<button
					type="submit"
					class="bg-red-500 hover:bg-red-600 text-white w-full px-3 py-2 rounded-full cursor-pointer"
					>Yes</button
				>
			</div>
		</form>
	</dialog>
</div>
