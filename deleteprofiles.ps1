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
        # Terminate processes using the profile directory
        $processes = Get-Process | Where-Object { $_.Path -like "$($profile.LocalPath)\*" }
        foreach ($process in $processes) {
            Write-Host "Terminating process: $($process.ProcessName) (ID: $($process.Id))"
            Stop-Process -Id $process.Id -Force
        }

        # Delete the user profile directory
        Remove-Item -Path $profile.LocalPath -Force -Recurse -ErrorAction Stop
    } catch {
        Write-Host "Failed to delete profile: $username. Error: $_"
    }
}
