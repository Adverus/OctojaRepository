$SMB1Protocol = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
if ($SMB1Protocol.State -ne 'Disabled' -and $SMB1Protocol.State -ne 'DisabledWithPayloadRemoved' ) {
    $output.State = "SMBv1 is enabled"
    $output.checkResult = 2
}
$output.State = "SMBv1 is disabled"
$output.checkResult = 0