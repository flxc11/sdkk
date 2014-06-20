<!--#Include File="Conn.asp"-->
<%
Session.CodePage = 65001
Response.Charset = "UTF-8"

Set Rsq=Server.CreateObject("Adodb.RecordSet")
Sqlq="Select * From SiteInfo"
Rsq.Open Sqlq,Conn,1,1
if not (Rsq.eof and Rsq.bof) then
SiteName=Rsq("SiteName")
SiyeKeys=Rsq("SiyeKeys")
enSiteName=Rsq("enSiteName")
enSiyeKeys=Rsq("enSiyeKeys")
SiteDes=Rsq("SiteDes")
SiteLogo=Rsq("SiteLogo")
SiteICP=Rsq("SiteICP")
SiteCopy=Rsq("SiteCopy")
Support=Rsq("Support")
SiteAuthor=Rsq("SiteAuthor")
SMTPServer=Rsq("SMTPServer")
SmtpFormMail=Rsq("SmtpFormMail")
SMTPUserName=Rsq("SMTPUserName")
SMTPUserPass=Rsq("SMTPUserPass")
end if
Rsq.Close
Set Rsq=Nothing
%>


<%
'**************单页显示
Function Readpage(txt,tst1)

Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From [SiteExplain] where ClassID='"&txt&"'"
Rs.Open Sql,Conn,1,1
If Not (Rs.Eof Or Rs.Bof) Then
Readpage=Rs(tst1)
End If
Rs.Close
Set Rs=Nothing

end Function

%>



