Add-Type -AssemblyName System.Windows.Forms

# Function to check if an update is available
function CheckUpdate {
    $currentVersion = "Version: 1.0.1"  # Replace with the current version defined in your script
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
$form.Size = New-Object System.Drawing.Size(310,440) # 310,350
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
    # Execute script 2
    "C:\test2.ps1"
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
    # Execute script 3
    "C:\test3.ps1"
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
    # Execute script 4
    "C:\Users\Frank\Desktop\Files\System\SystemBoost.bat.lnk"
})

$button5 = New-Object System.Windows.Forms.Button
$button5.Location = New-Object System.Drawing.Point(50,240)
$button5.Size = New-Object System.Drawing.Size(200,30)
$button5.Text = "Replace Certificates"
$button5.BackColor = [System.Drawing.ColorTranslator]::FromHtml("#282c33")
$button5.ForeColor = [System.Drawing.Color]::White
$button5.FlatStyle = "Flat"
$button5.FlatAppearance.BorderSize = 1
$button5.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button5.FlatAppearance.MouseDownBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button5.FlatAppearance.MouseOverBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)
$button5.Add_Click({
    $scriptUrl = "https://raw.githubusercontent.com/frankiec05/techtoolkit/main/replace_certs.bat"
    $tempScriptPath = "$env:TEMP\replace_certs.bat"

    try {
        # Download the script from the URL
        Invoke-WebRequest -Uri $scriptUrl -OutFile $tempScriptPath

        # Execute the batch script in a new command prompt window as administrator
        $process = Start-Process -FilePath "cmd.exe" -ArgumentList "/K `"$tempScriptPath`"" -Verb RunAs

        if ($process) {
            # Script started successfully
            [System.Windows.Forms.MessageBox]::Show("Script started successfully.", "Success", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        } else {
            # Failed to start the script
            [System.Windows.Forms.MessageBox]::Show("Failed to start the script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        }
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to download or run the script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})

$button6 = New-Object System.Windows.Forms.Button
$button6.Location = New-Object System.Drawing.Point(50,280)
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

# Create the label
$credits = New-Object System.Windows.Forms.Label
$credits.Text = "Made by Frank Cairo"
$credits.Location = New-Object System.Drawing.Point(50,320)
$credits.Size = New-Object System.Drawing.Size(200,20)
$credits.ForeColor = [System.Drawing.Color]::White

# Version Information
$versionUrl = "https://raw.githubusercontent.com/frankiec05/techtoolkit/main/lastupdate.txt"  # Replace with the URL of your version information
$response = Invoke-WebRequest -Uri $versionUrl
$versionText = $response.Content
$version = New-Object System.Windows.Forms.Label
$version.Text = "$versionText"
$version.Location = New-Object System.Drawing.Point(50,340)
$version.Size = New-Object System.Drawing.Size(200,20)
$version.ForeColor = [System.Drawing.Color]::White

# Suggestions Label
$suggestions = New-Object System.Windows.Forms.Label
$suggestions.Text = "Have a Suggestion or Bug?              Contact Me: facairo@mpsaz.org"
$suggestions.Location = New-Object System.Drawing.Point(50,370)
$suggestions.Size = New-Object System.Drawing.Size(200,30)
$suggestions.ForeColor = [System.Drawing.Color]::White

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
$form.Controls.Add($credits)
$form.Controls.Add($version)
$form.Controls.Add($suggestions)
# Show the form

$form.ShowDialog()
