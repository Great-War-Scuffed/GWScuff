# Regenerates the checksum build-stamp on_action so the multiplayer checksum changes
# on every release -- even when a balance edit doesn't land in a file/value the game's
# checksum actually hashes. Run this once, right before you commit/export a new build.

$stampFile = Join-Path $PSScriptRoot "..\common\on_actions\build_stamp_on_actions.txt"
$flag = "build_" + (Get-Date -Format "yyyyMMdd_HHmmss")

$content = @"
on_actions = {

	on_startup = {
		effect = {
			# Build stamp -- forces the MP checksum to change on every release, even when a
			# balance edit lands only in files the game's checksum doesn't hash. Regenerated
			# by scripts/bump_build_stamp.ps1 right before each push/export. Safe no-op:
			# this flag is never read anywhere.
			set_global_flag = $flag
		}
	}
}
"@

Set-Content -Path $stampFile -Value $content -Encoding UTF8
Write-Host "Checksum build stamp updated -> $flag"
