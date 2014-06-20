<%
Session.CodePage = 65001
Response.Charset = "UTF-8"
dim conn '定义一个连接变量 
dim conn2 '定义第二个连接变量 
'On Error Resume Next 
Server.ScriptTimeOut = 999999 '超时时间 
set conn=CreateObject("ADODB.Connection") 
conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database Password=;Data Source="&Server.MapPath("/%&(BkkKJB)KLG$%=+!f/JB)KLG$%=+!f.mdb") '要导入的Access数据库名称，这里是etwldbs.mdb 

set conn2=CreateObject("ADODB.Connection") 
conn2.Open "Provider=Microsoft.Jet.OLEDB.4.0;Jet OLEDB:Database Password=;Extended properties=Excel 5.0;Data Source="&Server.MapPath("/%&(BkkKJB)KLG$%=+!f/bbb.xls") '要导入的EXCEL表名称TEST.xls 
'----------------------------------------------------------------------------------------- 
'这里要说明的是，数据库和Excel表和该文件必须在网站同一目录里 
'----------------------------------------------------------------------------------------- 
sql = "Select * FROM [Sheet2$]" '要导入的Excel数据里面的表的名称，后面一定要加$ 
set rs = conn2.execute(sql) 
do while not rs.eof 
i=1
sql = "insert into UserReg1(Code,UserName,Campus,ISxz,Grade,ISGrade,Teach,ISTeach,Subject,Roomclass,TelPhone,Password1,Password2,PostTime) values('"&fixsql(rs(0))&"','"&fixsql(rs(1))&"','"&fixsql(rs(2))&"','"&fixsql(rs(3))&"','"&fixsql(rs(4))&"','"&fixsql(rs(5))&"','"&fixsql(rs(6))&"','"&fixsql(rs(7))&"','"&fixsql(rs(8))&"','"&fixsql(rs(9))&"','"&fixsql(rs(10))&"','"&fixsql(rs(11))&"','"&fixsql(rs(12))&"','"&Now()&"')" 
'其中的price是要导入的目标表，其后的company，fromhaven是price表中的字段名，但是要和后面的fixsql（rs（数字））要对应！ 
'response.write sql 
'response.end 
conn.execute(sql)
i=i+1
rs.movenext
Response.Write "正在插入 "&sql&"<Br>" 
'在这里输出执行的语句，可以去掉的！ 
Response.Flush 
loop
conn.close 
set conn = nothing 
conn2.close 
set conn2 = Nothing 
If Err = 0 Then 
'Response.Write "<script>alert('导入成功'),window.open('havenmanage.asp','_self')</script>" 
Else 
Response.Write "导入失败!" 
End If 
function fixsql(str) 
dim newstr 
newstr = str 
if isnull(newstr) then 
newstr = "" 
else 
newstr = replace(newstr,"'","''") 
end if 
fixsql = newstr 
end Function 
%>