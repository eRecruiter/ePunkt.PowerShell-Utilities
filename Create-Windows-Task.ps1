function Create-Windows-Task-That-Runs-Every-15-Minutes {
    param($name, $program, $programArguments, $username, $password)
    
    $service = New-Object -ComObject "Schedule.Service"
    $service.Connect($ENV:ComputerName)

    $rootFolder = $service.GetFolder("\")
    $taskDefinition = $service.NewTask(0)
      
    $trigger = $taskDefinition.Triggers.Create(2)
    $trigger.StartBoundary = (Get-Date 00:00AM).AddDays(1) | Get-Date -Format yyyy-MM-ddTHH:ss:ms
    $trigger.DaysInterval = 1
    $repetition = $trigger.Repetition
    $repetition.Duration = "P1D"
    $repetition.Interval = "PT15M"
   
    $action = $taskDefinition.Actions.Create(0)
    $action.Path = $program
    $action.Arguments = $programArguments
    
    $principal = $taskDefinition.Principal
    $principal.RunLevel = 0 # 0=normal, 1=Highest Privileges
       
    $rootFolder.RegisterTaskDefinition($name, $taskDefinition, 6, $username, $password, 1)
}

function Create-Windows-Task-That-Runs-Every-Midnight {
    param($name, $program, $programArguments, $username, $password)
    
    $service = New-Object -ComObject "Schedule.Service"
    $service.Connect($ENV:ComputerName)

    $rootFolder = $service.GetFolder("\")
    $taskDefinition = $service.NewTask(0)
      
    $trigger = $taskDefinition.Triggers.Create(2)
    $trigger.StartBoundary = (Get-Date 00:00AM).AddDays(1) | Get-Date -Format yyyy-MM-ddTHH:ss:ms
    $trigger.DaysInterval = 1
   
    $action = $taskDefinition.Actions.Create(0)
    $action.Path = $program
    $action.Arguments = $programArguments
    
    $principal = $taskDefinition.Principal
    $principal.RunLevel = 0 # 0=normal, 1=Highest Privileges
       
    $rootFolder.RegisterTaskDefinition($name, $taskDefinition, 6, $username, $password, 1)
}

