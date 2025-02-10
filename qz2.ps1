param (
    [ValidateSet("start", "stop", "up", "down")]
    [string]$Action
)

# Define paths to frontend and backend directories
$frontendPath = ".\frontend"
$backendPath = ".\backend"

# Define ports for frontend and backend
$frontendPort = 5173

# Store process information globally
$global:QuartzProcesses = @{}

# Function to start the frontend and backend processes
function Start-Quartz {
    Write-Host "Starting Quartz processes..." -ForegroundColor Cyan

    # Start the frontend process
    Write-Host "Starting frontend in $frontendPath..." -ForegroundColor Yellow
    Push-Location $frontendPath
    $frontendProcess = Start-Process -NoNewWindow -PassThru -FilePath "bun" -ArgumentList "run dev"
    Pop-Location
    $global:QuartzProcesses["frontend"] = $frontendProcess

    # Start the backend process
    Write-Host "Starting backend in $backendPath..." -ForegroundColor Yellow
    Push-Location $backendPath
    $backendProcess = Start-Process -NoNewWindow -PassThru -FilePath "zig" -ArgumentList "build run"
    Pop-Location
    $global:QuartzProcesses["backend"] = $backendProcess

    # Output status
    Write-Host ""
    Write-Host "=====================================" -ForegroundColor Green
    Write-Host "🚀 Quartz is running:" -ForegroundColor Green
    Write-Host "🌐 Frontend: http://localhost:$frontendPort" -ForegroundColor Yellow
    Write-Host "=====================================" -ForegroundColor Green
    Write-Host ""
}

# Function to stop all frontend and backend processes
function Stop-Quartz {
    Write-Host "Stopping Quartz processes..." -ForegroundColor Cyan

    # Stop the frontend process
    if ($global:QuartzProcesses["frontend"]) {
        $frontendProcess = $global:QuartzProcesses["frontend"]
        if (-not $frontendProcess.HasExited) {
            Write-Host "Stopping frontend..."
            Stop-Process -Id $frontendProcess.Id -Force
        }
        $global:QuartzProcesses["frontend"] = $null
    } else {
        Write-Host "No frontend process found."
    }

    # Stop the backend process
    if ($global:QuartzProcesses["backend"]) {
        $backendProcess = $global:QuartzProcesses["backend"]
        if (-not $backendProcess.HasExited) {
            Write-Host "Stopping backend..."
            Stop-Process -Id $backendProcess.Id -Force
        }
        $global:QuartzProcesses["backend"] = $null
    } else {
        Write-Host "No backend process found."
    }

    Write-Host "Quartz processes have been stopped." -ForegroundColor Green
}

# Main logic based on the argument
switch ($Action) {
    "start" { Start-Quartz }
    "stop" { Stop-Quartz }
    "up" { Start-Quartz }
    "down" { Stop-Quartz }
    default { Write-Host "Invalid action. Use 'start'/'up' or 'stop/'down'." -ForegroundColor Red }
}
