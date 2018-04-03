Copyright 2018 Eugene Pakhomov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

$domain = "https://<your_name>.visualstudio.com/"
$first = $domain + 'DefaultCollection/' 
$two = "/_apis/git/repositories?api-version=1.0"
$uri = $domain + 'DefaultCollection/_apis/projects?api-version=1.0'
$personalAccessToken = ""
$url = @()

$basic = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($personalAccessToken)"));

$basicAuthValue = "Basic $basic" 

$Headers = @{
    Authorization = $basicAuthValue
}


$webclient = New-Object System.Net.WebClient

$webclient.Headers["Authorization"] = "Basic $basic"


$jsonObj = Invoke-WebRequest -Uri $uri -Headers $Headers | ConvertFrom-Json


$jsonObj.value | foreach {$json=$_; $url += @($first + $json.name + $two)}

ForEach ($item in $url) {

$webclient.DownloadString($item)

}






