$ErrorActionPreference = "SilentlyContinue"
    $computer = (Read-Host "Enter Computername")
    $status = 'Enable'

    #   Get list of computers based on filter query and get thier names
    $computerArray = (Get-ADComputer -Filter ('Name -like "*' + $computer + '"')).Name
    #$computerArray = Get-Content C:\totalNotConnected.txt

     foreach ($singleComputer in $computerArray){
        if (Test-Connection -ComputerName $singleComputer -Count 1){

            Write-Host "$singleComputer [Online]" -ForeGround Green

            $biosSettings = Get-WmiObject -computername $singleComputer -Class HP_BIOSSettingInterface -Namespace root/hp/instrumentedBIOS

            $biosSettings.SetBIOSSetting('Num Lock State at Power-On','On')
            $biosSettings.SetBIOSSetting('After Power Loss','On')
            $biosSettings.SetBIOSSetting('Fast Boot',$status)
            $biosSettings.SetBIOSSetting('Legacy Support',$status)
            $biosSettings.SetBIOSSetting('Monday',$status)
            $biosSettings.SetBIOSSetting('Tuesday',$status)
            $biosSettings.SetBIOSSetting('Wednesday',$status)
            $biosSettings.SetBIOSSetting('Thursday',$status)
            $biosSettings.SetBIOSSetting('Friday',$status)
            $biosSettings.SetBIOSSetting('Saturday',$status)
            $biosSettings.SetBIOSSetting('Sunday',$status) 
            #| Select-Object return | write-host

        }else{
            Write-Host $singleComputer -ForeGround DarkGray 
            Write-Output -InputObject $singleComputer | Out-File -FilePath C:\notConnected.txt -Append
        }  
     }

