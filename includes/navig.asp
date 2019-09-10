				<nav>
					<ul id="navMenu">
<%
	Dim objFSO, objFile		'Object declarations for reading navbar textfile
	Dim intExpand			'0 = collapsed, 1 = expanded, 2 = no submenu
	
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

	
	Dim strPathToFile		'Work out the path from root to members includes textfile
	strPathToFile = Request.ServerVariables("APPL_PHYSICAL_PATH") & "/includes/navig.txt"

	Set objFile = objFSO.OpenTextFile(strPathToFile,1)

	Dim strCURL			'Holds current URL'		
	Dim strFileInformation		'One entire line from textfile
	Dim strSectionType		'M = Main level, S = Second level, T = Third level, F = Forth level, V = Fifth level
	Dim strLastSectionType		'Previous section type
	Dim strSectionName		'Holds the name of the menu item to be displayed on the screen
	Dim strFolder			'Holds the parent folder name of the current section
	Dim strSubfolder		'Holds the subfolder name of the current section, if present
	Dim strURL			'Holds the URL of the menu item link
	
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
			Response.Write("<li><a href=""" & strURL & """")
			If InStr(1, strCURL, strURL, 1) > 0 then
				Response.Write(" class=""active""")
			End If
			If strSectionName = "Home" then
				Response.Write(" accesskey=""1""")
			End If
			Response.Write(">" & strSectionName & "</a>")
			If InStr(strCURL, strFolder) > 0 then
				Response.Write("<ul>")
			Else
				Response.Write("</li>")
			End If
			strLastSectionType = strSectionType

		ElseIf strSectionType = "S" then
			If InStr(strCURL, strFolder) > 0 then
				If strLastSectionType = "T" then
					Response.Write("</ul></li>")
				ElseIf strLastSectionType = "F" then
					Response.Write("</ul></li></ul></li>")
				ElseIf strLastSectionType = "V" then
					Response.Write("</ul></li></ul></li></ul></li>")
				End If
				Response.Write("<li")
				If InStr(strCURL, strURL) > 0 then
					Response.Write(" class=""active""")
				End If
				Response.Write("><a href=""" & strURL & """")
				If InStr(strCURL, strURL) > 0 then
					Response.Write(" class=""active""")
				End If
				If strSectionName = "Contacts" then
					Response.Write(" accesskey=""9""")
				End If
				Response.Write(">" & strSectionName & "</a>")
				If strSubFolder = "" then
					Response.Write("</li>")
				Else
					If InStr(strCURL, strSubfolder & "/") > 0 then
						Response.Write("<ul>")
					Else
						Response.Write("</li>")
					End If
				End If
				strLastSectionType = strSectionType
			End If

		ElseIf strSectionType = "T" then
			If InStr(strCURL, strFolder & "/") > 0 then
				If strLastSectionType = "F" then
					Response.Write("</ul></li>")
				ElseIf strLastSectionType = "V" then
					Response.Write("</ul></li></ul></li>")
				End If
				Response.Write("<li")
				If InStr(strCURL, strURL) > 0 then
					Response.Write(" class=""active""")
				End If
				Response.Write("><a href=""" & strURL & """")
				If InStr(strCURL, strURL) > 0 then
					Response.Write(" class=""active""")
				End If				
				Response.Write(">" & strSectionName & "</a>")
				If strSubFolder = "" then
					Response.Write("</li>")
				Else
					If InStr(strCURL, strSubfolder & "/") > 0 then
						Response.Write("<ul>")
					Else
						Response.Write("</li>")
					End If
				End If
				strLastSectionType = strSectionType
			End If

		ElseIf strSectionType = "F" then
			If InStr(strCURL, strFolder & "/") > 0 then
				If strLastSectionType = "V" then
					Response.Write("</ul></li>")
				End If
				Response.Write("<li")
				If InStr(strCURL, strURL) > 0 then
					Response.Write(" class=""active""")
				End If
				Response.Write("><a href=""" & strURL & """")
				If InStr(strCURL, strURL) > 0 then
					Response.Write(" class=""active""")
				End If				
				Response.Write(">" & strSectionName & "</a>")
				If strSubFolder = "" then
					Response.Write("</li>")
				Else
					If InStr(strCURL, strSubfolder & "/") > 0 then
						Response.Write("<ul>")
					Else
						Response.Write("</li>")
					End If
				End If
				strLastSectionType = strSectionType
			End If

		ElseIf strSectionType = "V" then
			If InStr(strCURL, strFolder & "/") > 0 then
				Response.Write("<li")
				If InStr(strCURL, strURL) > 0 then
					Response.Write(" class=""active""")
				End If
				Response.Write("><a href=""" & strURL & """")
				If InStr(strCURL, strURL) > 0 then
					Response.Write(" class=""active""")
				End If				
				Response.Write(">" & strSectionName & "</a></li>")
				strLastSectionType = strSectionType
			End If
			
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
					</ul>
				</nav>
				<div class="hidden-sm hidden-xs" id="partners" aria-label="JWCRP partners">
					<p class="noBottomMargin"><strong>Our partners:</strong></p>
					<a href="https://www.bas.ac.uk/"><img src="/images/bas-logo.png" alt="British Antarctic Survey" title="go to the BAS website" class="fad2 img-responsive" /></a>
					<a href="https://www.ceh.ac.uk/"><img src="/images/ceh-logo.png" alt="Centre for Ecology and Hydrology" title="go to the CEH website" class="fad2 img-responsive" /></a>	
					<a href="https://www.ncas.ac.uk/"><img src="/images/ncas-logo.png" alt="National Centre for Atmospheric Science" title="go to the NCAS website" class="fad2 img-responsive" /></a>
					<a href="https://www.nceo.ac.uk/"><img src="/images/nceo-logo.png" alt="National Centre for Earth Observation" title="go to the NCEO website" class="fad2 img-responsive" /></a>
					<a href="http://noc.ac.uk/"><img src="/images/noc-logo.png" alt="National Oceanography Centre" title="go to the NOC website" class="fad2 img-responsive" /></a>
					<a href="http://www.pml.ac.uk/"><img src="/images/pml-logo.png" alt="Plymouth Marine Laboratory" title="go to the PML website" class="fad2 img-responsive" /></a>					
				</div>