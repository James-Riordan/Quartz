param (
    [ValidateSet("start", "stop", "up", "down")]
    [string]$Action
)

# Define paths to frontend and backend directories
$frontendPath = ".\frontend"
$backendPath = ".\backend"

# Define ports for frontend and backend
$frontendPort = 5173

# Function to start the frontend and backend processes
function Start-Quartz {
    Write-Host "Starting Quartz processes..." -ForegroundColor Cyan

    # Start frontend in a background job
    Start-Job -Name "frontend" -ScriptBlock {
        param ($frontendPath)
        Write-Host "Starting frontend in $frontendPath..."
        Push-Location $frontendPath
        bun run dev
        Pop-Location
    } -ArgumentList $frontendPath | Out-Null

    # Start backend in a background job
    Start-Job -Name "backend" -ScriptBlock {
        param ($backendPath)
        Write-Host "Building and starting backend in $backendPath..."
        Push-Location $backendPath
        zig build run
        Pop-Location
    } -ArgumentList $backendPath | Out-Null

    # Output status
    Write-Host ""
    Write-Host "=====================================" -ForegroundColor Green
    Write-Host "🚀 Quartz is running:" -ForegroundColor Green
    Write-Host "🌐 Frontend: http://localhost:$frontendPort" -ForegroundColor Yellow
    # Write-Host "🔗 Backend: $backendPath" -ForegroundColor Yellow
    Write-Host "=====================================" -ForegroundColor Green
    Write-Host ""
}

# Function to stop all frontend and backend jobs
function Stop-Quartz {
    Write-Host "Stopping Quartz processes..." -ForegroundColor Cyan

    # Stop frontend job
    $frontendJob = Get-Job -Name "frontend" -ErrorAction SilentlyContinue
    if ($frontendJob) {
        Write-Host "Stopping frontend..."
        Stop-Job -Job $frontendJob
        Remove-Job -Job $frontendJob
    } else {
        Write-Host "No frontend process found."
    }

    # Stop backend job
    $backendJob = Get-Job -Name "backend" -ErrorAction SilentlyContinue
    if ($backendJob) {
        Write-Host "Stopping backend..."
        Stop-Job -Job $backendJob
        Remove-Job -Job $backendJob
    } else {
        Write-Host "No backend process found."
    }

    Write-Host "Quartz processes have been stopped." -ForegroundColor Green
}

# Main logic based on the argument
switch ($Action) {
    "start" { Start-Quartz }
    "stop" { Stop-Quartz }
    "up" {Start-Quartz}
    "down" {Stop-Quartz}
    default { Write-Host "Invalid action. Use 'start'/'up' or 'stop/'down' ." -ForegroundColor Red }
}
