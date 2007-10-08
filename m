Return-Path: <keng_629@126.com>
Received: from m5-141.126.com (m5-141.126.com [202.108.5.141])
	by ozlabs.org (Postfix) with SMTP id 7AF75DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Oct 2007 20:05:34 +1000 (EST)
Date: Mon, 8 Oct 2007 17:34:24 +0800
From: "keng_629" <keng_629@126.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: problem  port linux  to MPC860T 
Message-ID: <200710081734236252201@126.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon847350440736_====="
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

--=====003_Dragon847350440736_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

 
recently i am working with porting the linux2.6.23 to MPC860T
i use the lighter to test where my kernel is now runing.
i find it out of control after the local_irq_enable() funciton in the asmlinkage void __init start_kernel(void) in init/main.c file.
Can somebody give me a hand?thank you

--=====003_Dragon847350440736_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3157" name=GENERATOR></HEAD>
<BODY><FONT face=Verdana size=2>&nbsp;</FONT>
<DIV><FONT face=Verdana size=2>recently i am working with&nbsp;porting the 
linux2.6.23 to MPC860T</FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2>i use the lighter to test where my kernel 
is now runing.</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2>i find it out of control after the 
local_irq_enable() funciton in the asmlinkage void __init start_kernel(void) in 
init/main.c file.</FONT></FONT></DIV>
<DIV><FONT face=Verdana size=2>Can somebody give me a hand?thank 
you</FONT></DIV>
<DIV><FONT face=Verdana><FONT color=#c0c0c0><FONT 
size=2></FONT></FONT>&nbsp;</DIV></FONT></BODY></HTML>

--=====003_Dragon847350440736_=====--
