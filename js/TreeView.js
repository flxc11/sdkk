//左侧导航
function showSub(ClassID)
{
    var obj=document.getElementById(ClassID);
    if (!obj) return;
    with(obj){
        style.display=(style.display=="block")?"none":"block";
    }
}
function changeIcon(objid)
{
    var obj=document.getElementById(objid);
    if (!obj) return;
    var tmpsrc=(obj.src.indexOf(picArr[2])==-1)?picArr[2]:picArr[1];
    obj.src=tmpsrc;
}

function getSubCls(topID)
{
    var tmpstr=eval("clsStr.match(/\\${3}"+topID+"\\|{2}[^$]*/g)");
    return tmpstr;
}

function listProCLass(ver)
{
    var tmpArr,tmp,tmp2,tmp3,tmp4,tmp5,icon;
    ver=(ver==1)?1:0;
    tmp=getSubCls(1);
    if (!tmp) return;
    for (var i=0;i<tmp.length;i++)
    {
        tmpArr=tmp[i].replace(/\${3}/,"").split("||");
        tmp2=getSubCls(tmpArr[1]);
        icon=picArr[0];
        if (!tmp2){
            document.writeln("<li class=\"pro\"><a href=\""+linkArr[ver]+"?ClassID="+tmpArr[1]+"\" id=\"prolink"+tmpArr[1]+"\">"+tmpArr[ver+2]+"</a></li>");//第一级栏目链接
        }
        else{
            document.writeln("<li class=\"pro\"><a href=\"javascript:void(0);  \"  onclick=\"showSub(\'cls"+tmpArr[1]+"\'); \" id=\"prolink"+tmpArr[1]+"\">"+tmpArr[ver+2]+"</a>");
        }
        if (!tmp2){continue;}
        document.writeln("<ul id=\"cls"+tmpArr[1]+"\" class=\"sub1\">");
        for (var j=0;j<tmp2.length;j++)
        {
            var tmpArr2=tmp2[j].replace(/\${3}/,"").split("||");
            tmp3=getSubCls(tmpArr2[1]);
            if (!tmp3){
                document.writeln("<li><a href=\""+linkArr[ver]+"?ClassID="+tmpArr2[1]+"\" id=\"prolink"+tmpArr2[1]+"\" class=\"p_r_10\">"+tmpArr2[ver+2]+"</a></li>");//第二级栏目链接
            }
            else{
                document.writeln("<li><a href=\"javascript:void(0);\" onclick=\"showSub(\'cls"+tmpArr2[1]+"\');changeIcon(\'cls"+tmpArr2[1]+"_icon\');\" id=\"prolink"+tmpArr2[1]+"\" class=\"p_r_10\">"+tmpArr2[ver+2]+"</a>");
            }
            

            if (!tmp3){continue;}
            document.writeln("<ul id=\"cls"+tmpArr2[1]+"\" class=\"sub2\">");
            for (var k=0;k<tmp3.length;k++)
            {
                var tmpArr3=tmp3[k].replace(/\${3}/,"").split("||");
                tmp4=getSubCls(tmpArr3[1]);
                if (!tmp4){
                    document.writeln("<li><a href=\""+linkArr[ver]+"?ClassID="+tmpArr3[1]+"\" id=\"prolink"+tmpArr3[1]+"\" class=\"p_r_10\">"+tmpArr3[ver+2]+"</a></li>");
                }
                else{
                    document.writeln("<li><a href=\"javascript:void(0);\" onclick=\"showSub(\'cls"+tmpArr3[1]+"\; ');changeIcon(\'cls"+tmpArr3[1]+"_icon\');\" id=\"prolink"+tmpArr3[1]+"\">"+tmpArr3[ver+2]+"</a></li>");
                }
            }
            document.writeln("</ul>");
       }
	   document.writeln("</ul>");
    }
	//document.writeln("<\/ul>");
}

//保留显示子系列
function keepSubCls()
{
    var tmpstr;
	
    var id;
    var panel;
    if (!ClassID.match(/^[1-9]\d*$/)) return;
    tmpstr=eval("clsStr.match(/\\${3}(\\d+)\\|{2}"+ClassID+"\\|{2}[^$]*/)");
    if (!tmpstr) return;
    tmpstr=tmpstr.toString();
    id=tmpstr.replace(/^\${3}(\d+)\|{2}.*/,"$1")
    panel=document.getElementById("cls"+id);
    if (!panel) return;
    panel.style.display="block";
    //改变当前系列的字体样式
    //document.getElementById("prolink"+ClassID).style.textDecoration="underline";
    document.getElementById("prolink"+ClassID).style.borderBottom="1px dashed #f60";
    
    while (id>0)
    {
        tmpstr=eval("clsStr.match(/\\${3}(\\d+)\\|{2}"+id+"\\|{2}[^$]*/)");
        if (!tmpstr) return;
        tmpstr=tmpstr.toString();
        id=tmpstr.replace(/^\${3}(\d+)\|{2}.*/,"$1");
        panel=document.getElementById("cls"+id);
        if (!panel) return;
        panel.style.display="block";
    }
}
