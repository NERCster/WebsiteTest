	<header>
		<div>
			<a href="#mainContent" class="displayOnFocus" accesskey="s">Skip to content</a>
		</div>
<%
Function CookieConsent()
	Dim strReturnURL
	Dim qS
	If Request.Querystring("cookieConsent") = "Y" Then ' Cookie consent has been given
		' Write consent cookie
		Response.Cookies("cookiesOK") = "Y"
		Response.Cookies("cookiesOK").Expires = Date() + 365
		strReturnURL = Request.ServerVariables("URL") & "?" & Request.ServerVariables("QUERY_STRING")
		strReturnURL = Replace(strReturnURL, "?cookieConsent=Y", "")
		strReturnURL = Replace(strReturnURL, "&cookieConsent=Y", "")
		strReturnURL = Replace(strReturnURL, "index.asp", "")
		Response.Redirect(strReturnURL)
	ElseIf Request.Cookies("cookiesOK") = "" Then ' No cookie exists
		If Request.Querystring = "" Then
			qS = "?"
		Else
			qS = "?" & Request.Querystring & "&"
		End If
		CookieConsent = "<section role=""dialog"" aria-label=""Cookie alert"" id=""cookieAlert"" class=""hidden-print""><p>This site is using cookies to record anonymous visitor statistics.</p><div id=""cookieOption""><a href=""" & Request.ServerVariables("URL") & qS & "cookieConsent=Y"" title=""Dismiss message""><strong>OK</strong></a></div></section>"
	Else
		'There is a cookie already
		Response.Cookies("cookiesOK").Expires = Date() + 365 ' Cookie exists so extend its expiry
	End If
End Function
Response.write(CookieConsent())
%>
		<div id="header">
			<!-- cloud image credit: Alex Gerst, NASA -->
				<div class="col-md-3 hidden-print" id="topLogos">
					<a href="https://www.metoffice.gov.uk/"><img src="/images/met-office-logo-black.png" alt="Met Office logo" title="go to the Met Office website" class="img-responsive" id="met-office" /><img src="/images/met-office-logo-black-small.png" alt="Met Office logo" title="go to the Met Office website" id="met-office-ie" /></a>
					<a href="https://nerc.ukri.org/"><img src="/images/nerc-logo.png" alt="NERC logo" title="go to the NERC website" class="img-responsive" /></a>
				</div>
				<div class="col-md-9">
					<h1>Joint Weather &amp; Climate Research Programme</h1>
					<h2>A partnership in weather and climate research</h2>
				</div>
		</div>
	</header>