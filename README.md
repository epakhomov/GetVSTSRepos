# GetVSTSRepos
A set of PowerShell scripts to download repositories from VSTS.

Uses VSTS api version 1.0 and
requires a personal token that can be generated in VSTS account settings. 

In order to download TFS repositories, use DownloadTFSRepos.ps1 in which $domain and $personalAccessToken variables should be assigned with corresponding values.

You can use GetGitRepoNames.ps1 to get the names of VSTS repositories that use git instead of TFS.
