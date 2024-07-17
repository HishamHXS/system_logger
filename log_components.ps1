# Log components in an easy-to-read format.

# Function to log CPU usage
function Log-CPUUsage {
    Write-Host "CPU Usage:"
    Get-WmiObject -Class Win32_Processor | ForEach-Object {
        [PSCustomObject]@{
            'Name'                 = $_.Name
            'NumberOfCores'        = $_.NumberOfCores
            'NumberOfLogicalProcessors' = $_.NumberOfLogicalProcessors
            'LoadPercentage'       = $_.LoadPercentage
        }
    } | Format-Table -AutoSize
    Write-Host "--------------------------"
}

# Function to log GPU usage
function Log-GPUUsage {
    Write-Host "GPU Usage:"
    Get-CimInstance -ClassName Win32_VideoController | ForEach-Object {
        [PSCustomObject]@{
            'Name'                = $_.Name
            'AdapterRAM (MB)'     = [math]::round($_.AdapterRAM / 1MB, 2)
            'DriverVersion'       = $_.DriverVersion
            'VideoModeDescription' = $_.VideoModeDescription
        }
    } | Format-Table -AutoSize
    Write-Host "--------------------------"
}


# Function to log memory usage
function Log-MemoryUsage {
    Write-Host "Memory Usage:"
    Get-CimInstance -ClassName Win32_OperatingSystem | ForEach-Object {
        [PSCustomObject]@{
            'TotalPhysicalMemory (GB)' = [math]::round($_.TotalVisibleMemorySize / 1GB, 2)
            'FreePhysicalMemory (GB)'  = [math]::round($_.FreePhysicalMemory / 1GB, 2)
            'TotalVirtualMemory (GB)'  = [math]::round($_.TotalVirtualMemorySize / 1GB, 2)
            'FreeVirtualMemory (GB)'   = [math]::round($_.FreeVirtualMemory / 1GB, 2)
        }
    } | Format-Table -AutoSize
    Write-Host "--------------------------"
}

# Function to log disk usage
function Log-DiskUsage {
    Write-Host "Disk Usage:"
    Get-CimInstance -ClassName Win32_LogicalDisk | ForEach-Object {
        [PSCustomObject]@{
            'Drive'          = $_.DeviceID
            'VolumeName'     = $_.VolumeName
            'Filesystem'     = $_.FileSystem
            'TotalSize (GB)' = [math]::round($_.Size / 1GB, 2)
            'FreeSpace (GB)' = [math]::round($_.FreeSpace / 1GB, 2)
        }
    } | Format-Table -AutoSize
    Write-Host "--------------------------"
}

# Log CPU usage
Log-CPUUsage

# Log GPU usage
Log-GPUUsage

# Log memory usage
Log-MemoryUsage

# Log disk usage
Log-DiskUsage
