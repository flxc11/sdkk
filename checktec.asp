<%
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
Session.CodePage = 65001
Response.Charset = "UTF-8"
CodeID=Request.Cookies("CNVP_CMS2")("Code")
If CodeID="" Then
Response.Redirect("teclogin.asp")
Response.End()
End If
%>