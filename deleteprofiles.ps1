$profilesToExclude = @("be2-admin", "jt-admin", "zo-admin", "kh2-admin", "sf2-admin", "NetworkService", "LocalService", "systemprofile", "autopilotstudent1", "autopilotteacher1", "Administrator", "DefaultAccount", "Frank", "Guest", "WDAGUtilityAccount", "defaultuser0", "saflynn")

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

        # Move the user profile directory to a temporary location
        $tempPath = Join-Path -Path $env:TEMP -ChildPath $username
        Move-Item -Path $profile.LocalPath -Destination $tempPath -Force

        # Delete the user profile directory from the temporary location
        Remove-Item -Path $tempPath -Force -Recurse -ErrorAction Stop
    } catch {
        Write-Host "Failed to delete profile: $username. Error: $_"
    }
}
