var hostName = "http://" + window.location.hostname;
var hostHref = window.location.href;
var tt;
var siteName;
$.get(hostHref,
	 {},
	 function(data){
	  tt = data.match(/<title>(.+)<\/title>/);
	  siteName=tt[1];
	 }
	);
function AddFavorite() 
{ 
	try
	{
		window.external.addFavorite(hostName,siteName); 
	}
	catch(e)
	{
		try
		{
			window.sidebar.addPanel(siteName, hostName, ""); 
		}
		catch(e)
		{
			alert("添加收藏夹失败，请手动添加");
		}
	}
}
function SetHomePage()
{
  if(window.netscape)
  {
        try
		{  
          	netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
        }  
        catch (e)  
        {  
			alert("浏览器拒绝了设为首页的操作！");  //地址栏-->about:config,signed.applets.codebase_principal_support=true  
        }
	var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
  	prefs.setCharPref('browser.startup.homepage',hostName);
  }
  else
  {
     document.getElementById("homepage").style.behavior='url(#default#homepage)';
   	 document.getElementById("homepage").sethomepage(hostName);
  }
}