Return-Path: <keng_629@126.com>
Received: from m5-143.126.com (m5-143.126.com [202.108.5.143])
	by ozlabs.org (Postfix) with SMTP id 58A86DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Sep 2007 20:02:42 +1000 (EST)
Date: Sun, 30 Sep 2007 17:32:49 +0800
From: "keng_629" <keng_629@126.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: problem wint port linux 2.6.23 to MPC860T 
Message-ID: <200709301732487507462@126.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon283016401130_====="
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

--=====003_Dragon283016401130_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

recently i am working with porting the linux2.6.23 to MPC860T
i don't have a good debugger,i use the lighter to test where my kernel is now runing.
i find it out of control after the local_irq_enable() funciton in the asmlinkage void __init start_kernel(void) in init/main.c file.
Can somebody give me a hand?thank you .




keng_629
2007-09-30

--=====003_Dragon283016401130_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3157" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Verdana><FONT size=2>recently i am working with&nbsp;porting the 
linux2.6.23 to MPC860T</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2>i don't have a good debugger,i use the 
lighter to test where my kernel is now runing.</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2>i find it out of control after the 
local_irq_enable() funciton in the asmlinkage void __init start_kernel(void) in 
init/main.c file.</FONT></FONT></DIV>
<DIV><FONT face=Verdana size=2>Can somebody give me a hand?thank you 
.</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV align=left><FONT face=Verdana size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" SIZE=2>
</FONT></DIV>
<DIV><FONT color=#c0c0c0><FONT face=Verdana size=2>keng_629</FONT></DIV>
<DIV><FONT face=Verdana size=2>2007-09-30</FONT></FONT></DIV></BODY></HTML>

--=====003_Dragon283016401130_=====--
