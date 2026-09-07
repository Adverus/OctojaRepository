# ── Octo Agent Wrapper (auto-generated) ──────────────
$ProgressPreference = 'SilentlyContinue'
$base64Input = [Console]::In.ReadLine()
$jsonInput = [System.Text.Encoding]::UTF8.GetString(
    [System.Convert]::FromBase64String($base64Input)
)
# NOTE: must NOT use $input — that name is a PowerShell automatic variable
# bound to the script's pipeline input (and stdin when redirected), which
# makes user-level assignment unreliable across PS versions.
$checkInput = $jsonInput | ConvertFrom-Json
$output = @{ checkResult = 0 }

# ── User Script ──────────────────────────────────────
# Wrapped in try/finally so the result is still serialized even if the user
# script calls `exit` or `return` (PowerShell runs `finally` on `exit`).
try {
try {
    $SMB1Protocol = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
    if ($SMB1Protocol.State -ne 'Disabled' -and $SMB1Protocol.State -ne 'DisabledWithPayloadRemoved' ) {
        $output.State = "SMBv1 is enabled"
        $output.checkResult = 2
    }
    $output.State = "SMBv1 is disabled"
    $output.checkResult = 0
} catch {
    $output.diagnosticInfo = $PSItem.Exception
    $output.resultMessage = "Unhandled Exception"
    $output.checkResult = 3
}
}
finally {
# ── Output (auto-generated) ──────────────────────────
# Markers must match CustomCheckScriptWrapper.ResultBeginMarker/ResultEndMarker.
$json = $output | ConvertTo-Json -Depth 10 -Compress
$bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
[Console]::Out.Write("<<<OCTO_RESULT_BEGIN>>>" + [System.Convert]::ToBase64String($bytes) + "<<<OCTO_RESULT_END>>>")
}