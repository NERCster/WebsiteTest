<%
	Function NERCFormatDate(dt,FullDate)
	
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' Purpose:	Converts a date in a given format to one in a different format
		' Inputs:	dt (String) : Date to be converted.
		' Outputs:	String - e.g. "26 May 06" (if input were 26-MAY-2006 or 26/05/2006).
		' Notes:	If a date is invalid, function will return "Error formatting date" message.
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		
		Dim FormattedDate
		Dim d
		On Error Resume Next
		FormattedDate = Day(dt) & " " & MonthName(Month(dt),TRUE) & " " & Year(dt)
		if FullDate then
			d = Weekday(dt)
			d = d - 1
			if d = 0 then d = 7
			FormattedDate = WeekDayName(d) & ", " & FormattedDate & " - " & ZeroPad(Hour(dt)) & ":" & ZeroPad(Minute(dt)) & ":" & ZeroPad(second(dt))
		end if
		
		If Err.Number <> 0 then
			NERCFormatDate = "Error formatting date"
		else
			NERCFormatDate = FormattedDate
		end if
	End Function
	
	Function FileLastMod()
	
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		' Purpose:	Returns the last modified date of the current file
		' Inputs: 	None
		' Outputs:	String - Date file was last modified (in appropriate format) - e.g. 26|05|06
		'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
		Dim loFs, lsFile, lsPath, loFile, ldLast
		
		' Create an instance of FileSystemObject object
		Set loFs = CreateObject("Scripting.FileSystemObject")
		
		' Get the logical path of the current file
		' (i.e. the file in which this code runs)
		lsFile = Request.ServerVariables("SCRIPT_NAME")
		
		' Get the physical path of the file
		lsPath = Server.MapPath(lsFile)
		
		' Get a handle/pointer to this file
		Set loFile = loFs.GetFile(lsPath)
		
		' Get the "Last Modified" property of this file
		ldLast = loFile.DateLastModified
		
		' Release the objects
		Set loFile = Nothing
		Set loFs = Nothing
		
		' Return value in appropriate format		
		FileLastMod = NERCFormatDate(ldLast,FALSE)
	End Function
%>