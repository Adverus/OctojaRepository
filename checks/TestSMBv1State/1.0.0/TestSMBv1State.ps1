$SMB1Protocol = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
if ($SMB1Protocol.State -ne 'Disabled' -and $SMB1Protocol.State -ne 'DisabledWithPayloadRemoved' ) {
    $output.State = "SMBv1 is enabled"
    $output.checkResult = 2
}
$output.State = "SMBv1 is disabled"
$output.checkResult = 0

$json = $output | ConvertTo-Json -Depth 10 -Compress
$bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
[Console]::Out.Write("<<<OCTO_RESULT_BEGIN>>>" + [System.Convert]::ToBase64String($bytes) + "<<<OCTO_RESULT_END>>>")