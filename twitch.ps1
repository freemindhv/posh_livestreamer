$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)


[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$title = 'Twitch Channel'
$msg   = 'Enter the twitch channel you want to watch:'

$twitch_channel = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
#$twitch_channel = Read-Host -Prompt "Enter the twitch channel you want to watch"


$url = "twitch.tv/"+$twitch_channel
$header = "Client-ID=cdmq41iul8hs3ytq8i82p5s5g6ehyng"
$bin = "livestreamer"
$quality = "best"

$cmd = {& $args[0] --http-header $args[1] $args[2] $args[3]}
$job = Start-Job -ScriptBlock $cmd -ArgumentList $bin, $header, $url, $quality

wait-job $job