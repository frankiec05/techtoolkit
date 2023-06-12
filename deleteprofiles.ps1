$profilesToExclude = @("zo-admin", "NetworkService", "LocalService", "systemprofile", "autopilotstudent1", "autopilotteacher1", "Administrator", "DefaultAccount", "Frank", "Guest", "WDAGUtilityAccount")

# Import the PSCX module
Import-Module Pscx

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

        # Unlock locked files within the user profile directory
        Get-ChildItem -Path $profile.LocalPath -Recurse | ForEach-Object {
            $filePath = $_.FullName
            try {
                Unlock-File -Path $filePath -Force
                Write-Host "Unlocked file: $filePath"
            } catch {
                Write-Host "Failed to unlock file: $filePath. Error: $_"
            }
        }

        # Delete the user profile directory
        Remove-Item -Path $profile.LocalPath -Force -Recurse -ErrorAction Stop
    } catch {
        Write-Host "Failed to delete profile: $username. Error: $_"
    }
}
