Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Win32 {
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

    public const int SW_HIDE = 0;
}
"@

# Hide the console window
$consoleWindowPtr = [Win32]::GetConsoleWindow()
[Win32]::ShowWindow($consoleWindowPtr, [Win32]::SW_HIDE)
Add-Type -AssemblyName System.Windows.Forms

# Function to check if an update is available
function CheckUpdate {
    $currentVersion = "Version: 1.0.2"  # Replace with the current version defined in your script
    $versionUrl = "https://raw.githubusercontent.com/frankiec05/techtoolkit/main/version.txt"

    try {
        # Get the version from the GitHub repository
        $response = Invoke-RestMethod -Uri $versionUrl
        $latestVersion = $response.Trim()

    # Compare the versions
    if ($latestVersion -ne $currentVersion) {
        $message = "Current Version: $currentVersion`nNew Version: $latestVersion"
        [System.Windows.Forms.MessageBox]::Show($message, "Tech Toolkit - Update Checker", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Update Check Failed", "Tech Toolkit - Update Checker", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
}

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Tech Toolkit"
$form.Size = New-Object System.Drawing.Size(310,435) # 310,350
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#131417")
$form.FormBorderStyle = 'FixedSingle'
$form.MaximizeBox = $false

$iconUrl = "https://raw.githubusercontent.com/frankiec05/techtoolkit/main/4359812.ico"  # Replace with the URL of your icon file

# Download the icon file from the URL
$iconPath = "$env:TEMP\icon.ico"  # Temporarily save the icon file locally
Invoke-WebRequest -Uri $iconUrl -OutFile $iconPath

# Create the icon object
$icon = New-Object System.Drawing.Icon($iconPath)

# Use the icon in your form
$form.Icon = $icon

# Clean up the temporary icon file
Remove-Item -Path $iconPath


# Create the buttons
$button1 = New-Object System.Windows.Forms.Button
$button1.Location = New-Object System.Drawing.Point(50,40)
$button1.Size = New-Object System.Drawing.Size(200,30)
$button1.Text = "Delete Profiles"
$button1.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282c33")
$button1.ForeColor = [System.Drawing.Color]::White
$button1.FlatStyle = "Flat"
$button1.FlatAppearance.BorderSize = 1
$button1.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button1.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button1.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button1.Region = New-Object System.Drawing.Region (New-Object System.Drawing.Drawing2D.GraphicsPath -argumentlist (New-Object System.Drawing.Drawing2D.EllipseRegion(New-Object System.Drawing.Rectangle(0, 0, $button1.Width, $button1.Height))))
$button1.Add_Click({
    $scriptUrl = "https://raw.githubusercontent.com/frankiec05/techtoolkit/main/deleteprofiles.ps1"
    $tempScriptPath = "$env:TEMP\deleteprofiles.ps1"

    try {
        # Download the script from the URL
        Invoke-WebRequest -Uri $scriptUrl -OutFile $tempScriptPath

        # Execute the script in a new PowerShell window as administrator
        $process = Start-Process -FilePath "Powershell.exe" -ArgumentList "-ExecutionPolicy RemoteSigned -NoExit -File `"$tempScriptPath`"" -Verb RunAs -PassThru

        if ($process.ExitCode -eq 0) {
            # Script completed successfully
            [System.Windows.Forms.MessageBox]::Show("Script completed successfully.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } else {
            # Script failed with non-zero exit code
            [System.Windows.Forms.MessageBox]::Show("Running Script...", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to download or run the script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})



$button2 = New-Object System.Windows.Forms.Button
$button2.Location = New-Object System.Drawing.Point(50,80)
$button2.Size = New-Object System.Drawing.Size(200,30)
$button2.Text = "Perform System Updates"
$button2.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282c33")
$button2.ForeColor = [System.Drawing.Color]::White
$button2.FlatStyle = "Flat"
$button2.FlatAppearance.BorderSize = 1
$button2.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button2.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button2.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button2.Add_Click({
    $scriptUrl = "https://raw.githubusercontent.com/frankiec05/techtoolkit/main/WindowsUpdate.ps1"
    $tempScriptPath = "$env:TEMP\WindowsUpdate.ps1"

    try {
        # Download the script from the URL
        Invoke-WebRequest -Uri $scriptUrl -OutFile $tempScriptPath

        # Execute the script in a new PowerShell window as administrator
        $process = Start-Process -FilePath "Powershell.exe" -ArgumentList "-ExecutionPolicy RemoteSigned -NoExit -File `"$tempScriptPath`"" -Verb RunAs -PassThru

        if ($process.ExitCode -eq 0) {
            # Script completed successfully
            [System.Windows.Forms.MessageBox]::Show("Script completed successfully.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } else {
            # Script failed with non-zero exit code
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to download or run the script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

$button3 = New-Object System.Windows.Forms.Button
$button3.Location = New-Object System.Drawing.Point(50,120)
$button3.Size = New-Object System.Drawing.Size(200,30)
$button3.Text = "Perform Lenovo Updates"
$button3.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282c33")
$button3.ForeColor = [System.Drawing.Color]::White
$button3.FlatStyle = "Flat"
$button3.FlatAppearance.BorderSize = 1
$button3.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button3.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button3.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button3.Add_Click({
    $scriptUrl = "https://raw.githubusercontent.com/frankiec05/techtoolkit/main/sufix.ps1"
    $tempScriptPath = "$env:TEMP\sufix.ps1"

    try {
        # Download the script from the URL
        Invoke-WebRequest -Uri $scriptUrl -OutFile $tempScriptPath

        # Execute the script in a new PowerShell window as administrator
        $process = Start-Process -FilePath "Powershell.exe" -ArgumentList "-ExecutionPolicy RemoteSigned -NoExit -File `"$tempScriptPath`"" -Verb RunAs -PassThru

        if ($process.ExitCode -eq 0) {
            # Script completed successfully
            [System.Windows.Forms.MessageBox]::Show("Script completed successfully.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } else {
            # Script failed with non-zero exit code
            [System.Windows.Forms.MessageBox]::Show("Running Script...", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to download or run the script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})
$button7 = New-Object System.Windows.Forms.Button
$button7.Location = New-Object System.Drawing.Point(50,160)
$button7.Size = New-Object System.Drawing.Size(200,30)
$button7.Text = "Reset WiFi Configuration"
$button7.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282c33")
$button7.ForeColor = [System.Drawing.Color]::White
$button7.FlatStyle = "Flat"
$button7.FlatAppearance.BorderSize = 1
$button7.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button7.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button7.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button7.Add_Click({
    # Run command prompt as administrator
    Start-Process "cmd.exe" -Verb RunAs -ArgumentList "/K ipconfig /release && ipconfig /renew && arp -d * && nbtstat -R && nbtstat -RR && ipconfig /flushdns && ipconfig /registerdns"

    # Note: The "/K" flag keeps the command prompt open after running the specified code
})

$button4 = New-Object System.Windows.Forms.Button
$button4.Location = New-Object System.Drawing.Point(50,200)
$button4.Size = New-Object System.Drawing.Size(200,30)
$button4.Text = "Fix Corrupted Files"
$button4.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282c33")
$button4.ForeColor = [System.Drawing.Color]::White
$button4.FlatStyle = "Flat"
$button4.FlatAppearance.BorderSize = 1
$button4.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button4.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button4.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button4.Add_Click({
    # Run command prompt as administrator
    Start-Process "cmd.exe" -Verb RunAs -ArgumentList "/K sfc /scannow && DISM /Online /Cleanup-Image /RestoreHealth && sfc /scannow"

    # Note: The "/K" flag keeps the command prompt open after running the specified code
})

$button6 = New-Object System.Windows.Forms.Button
$button6.Location = New-Object System.Drawing.Point(50,240)
$button6.Size = New-Object System.Drawing.Size(200,30)
$button6.Text = "Update Group Policy"
$button6.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282c33")
$button6.ForeColor = [System.Drawing.Color]::White
$button6.FlatStyle = "Flat"
$button6.FlatAppearance.BorderSize = 1
$button6.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button6.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button6.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button6.Add_Click({
    # Run command prompt as administrator
    Start-Process "cmd.exe" -Verb RunAs -ArgumentList "/K gpupdate /force"

    # Note: The "/K" flag keeps the command prompt open after running the specified code
})

$button8 = New-Object System.Windows.Forms.Button
$button8.Location = New-Object System.Drawing.Point(50,280)
$button8.Size = New-Object System.Drawing.Size(200,30)
$button8.Text = "Delete Temp Files"
$button8.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282c33")
$button8.ForeColor = [System.Drawing.Color]::White
$button8.FlatStyle = "Flat"
$button8.FlatAppearance.BorderSize = 1
$button8.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button8.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button8.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button8.Add_Click({
    # Create a temporary folder to store the files for deletion
$tempFolder = Join-Path -Path $env:Temp -ChildPath "TempCleanup"
New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null

$failedFiles = @()  # Array to store the paths of failed files
$deletedFilesList = @()  # Array to store the paths of deleted files

# Move the files to the temporary folder
$foldersToClean = @(
    $env:Temp,
    (Join-Path -Path $env:windir -ChildPath "Temp"),
    (Join-Path -Path $env:windir -ChildPath "Prefetch"),
    (Join-Path -Path $env:windir -ChildPath "SoftwareDistribution\Download"),
    (Join-Path -Path $env:LocalAppData -ChildPath "Temp"),
    (Join-Path -Path $env:LocalAppData -ChildPath "Microsoft\Windows\INetCache"),
    (Join-Path -Path $env:LocalAppData -ChildPath "Microsoft\Windows\Temporary Internet Files"),
    (Join-Path -Path $env:UserProfile -ChildPath "AppData\Local\Temp"),
    (Join-Path -Path $env:UserProfile -ChildPath "AppData\Local\Microsoft\Windows\INetCache"),
    (Join-Path -Path $env:UserProfile -ChildPath "AppData\Local\Microsoft\Windows\Temporary Internet Files"),
    (Join-Path -Path $env:ProgramData -ChildPath "Temp"),
    (Join-Path -Path $env:ProgramData -ChildPath "Microsoft\Windows\INetCache"),
    (Join-Path -Path $env:ProgramData -ChildPath "Microsoft\Windows\Temporary Internet Files"),
    "C:\Windows\Temp",
    "C:\Windows\Prefetch",
    "C:\Windows\SoftwareDistribution\Download",
    "C:\Path\To\Additional\Temp\Folder1",
    "C:\Path\To\Additional\Temp\Folder2"
    # Add more folders here...
)

$foldersToClean | ForEach-Object {
    Get-ChildItem -Path $_ -File -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            Move-Item -Path $_.FullName -Destination $tempFolder -Force -ErrorAction Stop
            $deletedFilesList += $_.FullName  # Add the path to the list of deleted files
        } catch {
            $failedFiles += $_.FullName
        }
    }
}

# Check if the temporary folder exists before attempting to remove its contents
if (Test-Path -Path $tempFolder) {
    # Get the count of deleted files (excluding the failed files)
    $deletedFilesCount = @(Get-ChildItem -Path $tempFolder -File -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notin $failedFiles }).Count

    # Delete the temporary folder and its contents
    Remove-Item -Path $tempFolder -Force -Recurse -ErrorAction SilentlyContinue
} else {
    # Temporary folder does not exist, set deleted files count to 0
    $deletedFilesCount = 0
}

# Prepare the message to be displayed
if ($deletedFilesCount -eq 0) {
    $message = "No temporary files were deleted."
} else {
    $message = "Successfully deleted $deletedFilesCount temporary file(s). "
}

# Store the list of deleted files in a text file
$fileContent = $deletedFilesList -join "`r`n"
$filePath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads\DeletedFilesList.txt"

if (Test-Path -Path $filePath) {
    # If the file already exists, append the new list to the existing file
    $fileContent | Out-File -FilePath $filePath -Append -Encoding UTF8
} else {
    # If the file doesn't exist, create a new file and write the list to it
    $fileContent | Out-File -FilePath $filePath -Encoding UTF8
}

# Display the message using PresentationFramework assembly
Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show($message, "Temp Files Cleaner", [System.Windows.MessageBoxButton]::OK) | Out-Null

})

# Create the label
$credits = New-Object System.Windows.Forms.Label
$credits.Text = "Made by Frank Cairo"
$credits.Location = New-Object System.Drawing.Point(50,320)
$credits.Size = New-Object System.Drawing.Size(200,15)
$credits.ForeColor = [System.Drawing.Color]::White
$credits.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter

# Version Information
$versionUrl = "https://raw.githubusercontent.com/frankiec05/techtoolkit/main/lastupdate.txt"  # Replace with the URL of your version information
$response = Invoke-WebRequest -Uri $versionUrl -UseBasicParsing
$versionText = $response.Content
$version = New-Object System.Windows.Forms.Label
$version.Text = "$versionText"
$version.Location = New-Object System.Drawing.Point(50,340)
$version.Size = New-Object System.Drawing.Size(200,20)
$version.ForeColor = [System.Drawing.Color]::White
$version.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter

# Suggestions Label
$suggestions = New-Object System.Windows.Forms.Label
$suggestions.Text = "Have a Suggestion or Bug?              Contact Me: facairo@mpsaz.org"
$suggestions.Location = New-Object System.Drawing.Point(50,360)
$suggestions.Size = New-Object System.Drawing.Size(200,30)
$suggestions.ForeColor = [System.Drawing.Color]::White
$suggestions.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter

# Check for update availability
CheckUpdate

# Add the buttons to the form
$form.Controls.Add($button1)
$form.Controls.Add($button2)
$form.Controls.Add($button3)
$form.Controls.Add($button4)
$form.Controls.Add($button5)
$form.Controls.Add($button6)
$form.Controls.Add($button7)
$form.Controls.Add($button8)
$form.Controls.Add($credits)
$form.Controls.Add($version)
$form.Controls.Add($suggestions)
# Show the form

$form.ShowDialog()
