Copyright 2018 Eugene Pakhomov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


$domain = "https://<your_name>.visualstudio.com/"
$uri = $domain + '/DefaultCollection/_apis/projects?api-version=1.0'
$personalAccessToken = ""
$api = "/_api/_versioncontrol/itemContentZipped?repositoryId=&path=$/"
$version = "&version=T&__v=5"
$url = @()
$OutPath = "/path/to/save/files/" #don't forget to use the slash at the end
$webclient = New-Object System.Net.WebClient
 
$basic = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"));
$basicAuthValue = "Basic $basic" 

$Headers = @{
    Authorization = $basicAuthValue
}
 
 $jsonObj = Invoke-WebRequest -Uri $uri -Headers $Headers | ConvertFrom-Json

 $webclient.Headers["Authorization"] = "Basic $basic"


 $jsonObj.value | foreach {$json=$_; $url += @($domain + $json.id + $api + $json.name + $version)}
 
 
 ForEach ($item in $url) {
    
 $file = $OutPath +  ($item).split('/')[-5] + ".zip"
 
 $webclient.DownloadFile($item, $file)
 
 }
