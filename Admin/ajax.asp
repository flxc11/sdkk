<!--#include file="../Config/Conn.asp" -->
<!--#include file="../Include/Class_Function.asp" -->
<%
	Action =Request("Action")
	select case Action
	case "0"
		addnum()
	case "1"
		Subtrnum()
	case "2"
		addnum()
	case "APP"
		APP()
	case "Experi"
		Experi()
	case else
		addnum()
	End select
%>
<%
	Sub addnum()
	ID=ReplaceBadChar(Trim(Request("ID")))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From SetsExperiments where ID="&ID
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
		instru_char = split(Rs("ExperiInstrument"),",")
		num_char = split(left(Rs("ExperiNumber"),len(Rs("ExperiNumber"))-1),",")
		for i=LBound(instru_char) to UBound(instru_char)
			Set Rsw = Server.CreateObject("Adodb.RecordSet")
			Sqlw = "Select * From shopinfo where ID="&instru_char(i)
			Rsw.Open Sqlw,Conn,1,3
			Rsw("numb2") = (Rsw("numb2")+num_char(i)*Rs("ExperiSats"))
			Rsw.Update
			Rsw.Close:Set Rsw=Nothing
		next
	end if
	Rs.Close:Set Rs=Nothing
	End Sub
	
	Sub Subtrnum()
	ID=ReplaceBadChar(Trim(Request("ID")))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From SetsExperiments where ID="&ID
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
		ts = Rs("ExperiSats")
		instru_char = split(Rs("ExperiInstrument"),",")
		num_char = split(left(Rs("ExperiNumber"),len(Rs("ExperiNumber"))-1),",")
		for i=LBound(instru_char) to UBound(instru_char)
			Set Rsw = Server.CreateObject("Adodb.RecordSet")
			Sqlw = "Select * From shopinfo where ID="&instru_char(i)
			Rsw.Open Sqlw,Conn,1,3
			'Response.Write(cstr(Rsw("numb2"))&"adsf")
			'Response.Write(cstr(ts))
			'Response.End()
			Rsw("numb2") = cstr(Rsw("numb2"))-cstr(ts)*num_char(i)
			Rsw.Update
			Rsw.Close:Set Rsw=Nothing
		next
	end if
	Rs.Close:Set Rs=Nothing
	End Sub
	
	Sub APP()
	parentName=ReplaceBadChar(Trim(Request("parentName")))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From NewsClass where NavParent=(select ID from NewsClass where NavTitle='"&parentName&"')"
	Rs.Open Sql,Conn,1,1
	html1="{""Infolist"":["
	html2=""
	i=0
	do while not Rs.Eof
	if i<Rs.RecordCount-1 then
	html2=html2&"{""SubName"":"""&Rs("NavTitle")&""""&"},"
	else
	html2=html2&"{""SubName"":"""&Rs("NavTitle")&""""&"}"
	end if
	i=i+1
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
	html1=html1&html2&"]}"
	Response.Write(html1)
	End Sub
	
	Sub Experi()
		Grade=ReplaceBadChar(Trim(Request("Grade")))
		Unit=ReplaceBadChar(Trim(Request("Unit")))
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql = "Select * From setsexperiments where ExperiGrade='"&Grade&"' and ExperiUnit='"&Unit&"'"
		Rs.Open Sql,Conn,1,1
		expe1="{""Infolist"":["
		expe2=""
		i=0
		do while not Rs.Eof
		if i<Rs.RecordCount-1 then
		expe2=expe2&"{""ExperiTitle"":"""&Rs("ExperiTitle")&""","&"""ID"":"""&Rs("ID")&"""},"
		else
		expe2=expe2&"{""ExperiTitle"":"""&Rs("ExperiTitle")&""","&"""ID"":"""&Rs("ID")&"""}"
		end if
		i=i+1
		Rs.MoveNext
		Loop
		Rs.Close:Set Rs=Nothing
		expe1=expe1&expe2&"]}"
		Response.Write(expe1)
		End Sub
%>