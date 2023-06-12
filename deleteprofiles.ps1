$profilesToExclude = @("*-admin", "NetworkService", "LocalService", "systemprofile", "autopilot*", "Administrator", "DefaultAccount", "Frank", "Guest", "WDAGUtilityAccount")

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
    try {
        Remove-WmiObject -InputObject $profile -ErrorAction Stop
    } catch {
        Write-Host "Failed to delete profile: $username. Error: $_"
    }
}
