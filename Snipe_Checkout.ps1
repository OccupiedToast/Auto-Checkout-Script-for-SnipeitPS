Import-Module SnipeitPS
Connect-SnipeitPS -URL 'exampleURL.com' -apiKey 'exampleAPIkey'

#### Textbox 0 ####

    ### Creating the form with the Windows forms namespace
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
$form0 = New-Object System.Windows.Forms.Form
#$form0.ControlBox = $false
$form0.Text = 'Please enter the asset tag of this computer' ### Text to be displayed in the title
$form0.Size = New-Object System.Drawing.Size(310,100) ### Size of the window
$form0.StartPosition = 'CenterScreen'  ### Optional - specifies where the window should start
$form0.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow  ### Optional - prevents resize of the window
$form0.Topmost = $true  ### Optional - Opens on top of other windows
### Adding an OK button to the text box window
$OKButton0 = New-Object System.Windows.Forms.Button
$OKButton0.Location = New-Object System.Drawing.Point(210,35) ### Location of where the button will be
$OKButton0.Size = New-Object System.Drawing.Size(75,23) ### Size of the button
$OKButton0.Text = 'Apply' ### Text inside the button
$OKButton0.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form0.AcceptButton = $OKButton0
$form0.Controls.Add($OKButton0)
### Adding a Cancel button to the text box window
#$CancelButton = New-Object System.Windows.Forms.Button
#$CancelButton.Location = New-Object System.Drawing.Point(70,550) ### Location of where the button will be
#$CancelButton.Size = New-Object System.Drawing.Size(75,23) ### Size of the button
#$CancelButton.Text = 'Cancel' ### Text inside the button
#$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
#$form.CancelButton = $CancelButton
#$form.Controls.Add($CancelButton)
### Putting a label above the text box
$label0 = New-Object System.Windows.Forms.Label
$label0.Location = New-Object System.Drawing.Point(10,10) ### Location of where the label will be
$label0.AutoSize = $True
$Font0 = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold) ### Formatting text for the label
$label0.Font = $Font0
$label0.Text = $Input_Type0 ### Text of label, defined by the parameter that was used when the function is called
$label0.ForeColor = 'Red' ### Color of the label text
$form0.Controls.Add($label0)
### Inserting the text box that will accept input
$textBox0 = New-Object System.Windows.Forms.TextBox
$textBox0.Location = New-Object System.Drawing.Point(10,10) ### Location of the text box
$textBox0.Size = New-Object System.Drawing.Size(275,50) ### Size of the text box
$textBox0.Multiline = $false ### Allows multiple lines of data
$textbox0.AcceptsReturn = $true ### By hitting enter it creates a new line
$textBox0.ScrollBars = "Vertical" ### Allows for a vertical scroll bar if the list of text is too big for the window
$form0.Controls.Add($textBox0)


function Textbox0 {
    $form0.Text = "Please enter name"
    $x0 = ""
$form0.Add_Shown({$textBox0.Select()}) ### Activates the form and sets the focus on it
$result0 = $form0.ShowDialog() ### Displays the form 
$A00 = "A00*"
### If the OK button is selected do the following
if ($result0 -eq [System.Windows.Forms.DialogResult]::OK)
{
    ### Removing all the spaces and extra lines
    $x0 = $textBox0.Lines | Where{$_} | ForEach{ $_.Trim() }
    ### Putting the array together
    $Tag0 = @()
    ### Putting each entry into array as individual objects
    $Tag0 = $x0 -split "`r`n"

$Name = Get-SnipeitUser -search "$Tag0" 
Write-Host "You are about to checkout the items in status label 'Moving', to user: `n `n $Name `n `n and send them to status label 'Ready to Deploy', if this is not correct, do NOT press enter. Close the window and `n retry, making sure the name you entered is correctly spelled. Also try using the username instead of the actual name as it seems to work better. NOTE: YOU MAY NEED TO RUN THIS COMMAND MULTIPLE TIMES AS THE CREATOR OF THIS SCRIPT IS A DUMMY AND CAN'T FIGURE OUT HOW TO PUT IT IN A LOOP WITHOUT BREAKING IT. Thank you."
Pause
Get-SnipeitAsset -status_id 4 
$Asset = Get-SnipeitAsset -status_id 4  
$array = ($Asset.id)
$array.count
Pause
$array | ForEach-Object {
    Set-SnipeitAssetOwner -id $PSItem -assigned_id $Name.id -checkout_to_type user
    Set-SnipeitAsset -id $PSItem -status_id 2
    }

Pause
}
}
Textbox0
