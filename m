Return-Path: <chengk_thomson@sina.com>
Received: from smtp.sina.com.cn (smtp.sina.com.cn [202.108.3.233])
	by ozlabs.org (Postfix) with ESMTP id BD749DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 00:45:31 +1100 (EST)
Received: from imageasus (unknown [219.142.185.7])
	by smtp.sina.com.cn (SINAMAIL) with ESMTP id C8F625DD008
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jan 2008 21:45:25 +0800 (CST)
Date: Thu, 24 Jan 2008 21:45:26 +0800
From: "chengk_thomson" <chengk_thomson@sina.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: mpc8247 porting problem
Message-ID: <200801242144198436268@sina.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon863156158505_====="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

--=====003_Dragon863156158505_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hello:
I'm porting linux 2.6.18 to a MPC8247 platform. 
now I encounter a strange situation. kernel enter a dead loop in __div64_32() which is called by time_init() in start_kernel().
I have modify the dtb file according the customer's board.
does anybody has any idea?

BR
2008-01-24 



chengk_thomson 

--=====003_Dragon863156158505_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3243" name=GENERATOR>
<STYLE>BLOCKQUOTE {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em
}
OL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
UL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
</STYLE>
</HEAD>
<BODY style="FONT-SIZE: 10pt; FONT-FAMILY: verdana">
<DIV><FONT face=Verdana size=2>Hello:</FONT></DIV>
<DIV style="TEXT-INDENT: 2em">I'm porting linux 2.6.18 to a MPC8247 platform. 
</DIV>
<DIV style="TEXT-INDENT: 2em">now&nbsp;I&nbsp;encounter a strange situation. 
<FONT color=navy><SPAN style="COLOR: navy">kernel enter a dead loop in 
__div64_32() which is called by time_init() in 
start_kernel().</SPAN></FONT></DIV>
<DIV style="TEXT-INDENT: 2em"><FONT color=navy><SPAN 
style="COLOR: navy"></SPAN></FONT><FONT color=#0aceda size=2><SPAN lang=EN-US 
style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Verdana">I have modify the dtb 
file according the customer's board.</SPAN></FONT></DIV>
<DIV style="TEXT-INDENT: 2em"><FONT color=#0aceda size=2><SPAN lang=EN-US 
style="FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Verdana">does anybody has any 
idea?</SPAN></FONT><FONTSIZE=2 face="Verdana"></FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV>BR</DIV>
<DIV align=left><FONT face=Verdana color=#c0c0c0 size=2>2008-01-24 
</FONT></DIV><FONT face=Verdana size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" align=left SIZE=2>

<DIV><FONT face=Verdana color=#c0c0c0 size=2><SPAN>chengk_thomson</SPAN> 
</FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon863156158505_=====--
