Import-Module AWS.Tools.S3

$region = "us-east-2"
$bucketName = Read-Host -Prompt 'Enter the S3 bucket name'

Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $bucketName"

function BucketExist{
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
    return $null -ne $bucket
}

if(-not (BucketExist)){
    Write-Host "Bucket does not exist..."
    New-S3Bucket -BucketName $bucketName -Region $region
}else{
    Write-Host "Bucket already exist..."
}

# Create a new file

$fileName = 'myfile.txt'
$fileContent = 'Hello world'
Set-Content -Path $fileName -Value $fileContent

Write-S3Object -BucketName $bucketName -File $fileName -Key $fileName

