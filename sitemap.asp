<!--#include virtual="/includes/head.asp"-->
    <title>Joint Weather and Climate Research Programme (JWCRP) - Sitemap</title>
</head>
<body>
<!--#include virtual="/includes/header.asp"-->
	<div class="container">
		<div class="row">
			<aside class="col-lg-3 col-lg-push-9 col-md-4 col-md-push-8 hidden-print" aria-label="Site navigation">
				<!--#include virtual="/includes/navig.asp"-->
			</aside>
			<main class="col-lg-9 col-lg-pull-3 col-md-8 col-md-pull-4" aria-labelledby="mainContent">
				<h1 id="mainContent">Sitemap</h1>

<ul>
<%
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set objFile = objFSO.OpenTextFile(strPathToFile,1)
	
	strCURL = Request.ServerVariables("URL")
	strLastSectionType = "M"
	
	Do While Not objFile.AtEndOfStream
		strFileInformation = objFile.Readline
		strSectionType = Left(strFileInformation, 1)
		strSectionName = Mid(strFileInformation, 3, InStr(strFileInformation, "*") - 3)
		strFolder = Mid(strFileInformation, InStr(strFileInformation, "*") + 1, InStr(strFileInformation, "+") - InStr(strFileInformation, "*") - 1)
		strSubfolder = Mid(strFileInformation, InStr(strFileInformation, "+") + 1, InStr(strFileInformation, "$") - InStr(strFileInformation, "+") - 1)
		strURL = Mid(strFileInformation, InStr(strFileInformation, "$") + 1, InStr(strFileInformation, "#") - InStr(strFileInformation, "$") - 1)

		If strSectionType = "M" then
			If strLastSectionType = "S" then
				Response.Write("</ul></li>")
			ElseIf strLastSectionType = "T" then
				Response.Write("</ul></li></ul></li>")
			ElseIf strLastSectionType = "F" then
				Response.Write("</ul></li></ul></li></ul></li>")
			ElseIf strLastSectionType = "V" then
				Response.Write("</ul></li></ul></li></ul></li></ul></li>")
			End If
			Response.Write("<li><a href=""" & strURL & """>" & strSectionName & "</a>")
			If InStr(strURL, strFolder) > 0 then
				Response.Write("<ul>")
			Else
				Response.Write("</li>")
			End If
			strLastSectionType = strSectionType
		ElseIf strSectionType = "S" then
			If strLastSectionType = "T" then
				Response.Write("</ul></li>")
			ElseIf strLastSectionType = "F" then
				Response.Write("</ul></li></ul></li>")
			ElseIf strLastSectionType = "V" then
				Response.Write("</ul></li></ul></li></ul></li>")
			End If
			Response.Write("<li><a href=""" & strURL & """>" & strSectionName & "</a>")
			If strSubFolder = "" then
				Response.Write("</li>")
			Else
				Response.Write("<ul>")
			End If
			strLastSectionType = strSectionType
		ElseIf strSectionType = "T" then
			If strLastSectionType = "F" then
				Response.Write("</ul></li>")
			ElseIf strLastSectionType = "V" then
				Response.Write("</ul></li></ul></li>")
			End If
			Response.Write("<li><a href=""" & strURL & """>" & strSectionName & "</a>")
			If strSubFolder = "" then
				Response.Write("</li>")
			Else
				Response.Write("<ul>")
			End If
			strLastSectionType = strSectionType
		ElseIf strSectionType = "F" then
			If strLastSectionType = "V" then
				Response.Write("</ul></li>")
			End If
			Response.Write("<li><a href=""" & strURL & """>" & strSectionName & "</a>")
			If strSubFolder = "" then
				Response.Write("</li>")
			Else
				Response.Write("<ul>")
			End If
			strLastSectionType = strSectionType			
		ElseIf strSectionType = "V" then
			Response.Write("<li><a href=""" & strURL & """>" & strSectionName & "</a></li>")
			strLastSectionType = strSectionType
		End If
	Loop	
	
	If strLastSectionType = "S" then
		Response.Write("</ul></li>")
	ElseIf strLastSectionType = "T" then
		Response.Write("</ul></li></ul></li>")
	ElseIf strLastSectionType = "F" then
		Response.Write("</ul></li></ul></li></ul></li>")
	ElseIf strLastSectionType = "V" then
		Response.Write("</ul></li></ul></li></ul></li></ul></li>")
	End If
	Set objFile = Nothing
	Set objFSO = Nothing
%>
	<li><a href="/sitemap.asp">Sitemap</a></li>
</ul>
				
			</main>
		</div>
<!--#include virtual="/includes/footer.asp"-->