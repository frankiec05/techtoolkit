$profilesToExclude = @("*-admin", "NetworkService", "LocalService", "systemprofile", "autopilot*")

# Get a list of all user profiles
$profiles = Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.Special -eq $false }

foreach ($profile in $profiles) {
    $username = $profile.LocalPath.Split('\')[-1]

    # Skip excluded profiles
    if ($profilesToExclude -contains $username) {
        Write-Host "Skipping profile: $username"
        continue
    }

    # Delete the user profile
    Write-Host "Deleting profile: $username"
    $profile.Delete()
}
