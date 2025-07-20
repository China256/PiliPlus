# 获取当前工作目录（运行脚本时的所在目录）
$currentDir = Get-Location

# 获取上级目录
$parentDir = Split-Path $currentDir -Parent

# 获取时间戳
$build_time = [int][double]::Parse((Get-Date -UFormat %s))

# 获取 git commit hash
$commit_hash = (git rev-parse HEAD).Trim()

# 拼接内容
$content = @"
class BuildConfig {
  static const int buildTime = $build_time;
  static const String commitHash = '$commit_hash';
}
"@

# 目标文件路径
$targetFile = Join-Path $parentDir "build_config.dart"

# 写入文件
$content | Set-Content -Encoding UTF8 $targetFile

Write-Host "生成完毕: $targetFile"
