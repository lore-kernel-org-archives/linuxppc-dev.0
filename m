Return-Path: <keng_629@126.com>
Received: from m5-141.126.com (m5-141.126.com [202.108.5.141])
	by ozlabs.org (Postfix) with SMTP id 7F8CFDDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Oct 2007 13:15:35 +1000 (EST)
Date: Mon, 15 Oct 2007 11:15:36 +0800
From: "keng_629" <keng_629@126.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: mpc 860 boot linux2.6.23 problem
Message-ID: <200710151115352659084@126.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon450500532701_====="
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

--=====003_Dragon450500532701_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit


i am proting linux2.63.23 to mpc860t board with uboot1.1.4 as bootloader.
my bootargs is root=/dev/ram rw init=/linuxrc.
i use debugger to see the regedits, find pc is run in the cpu_idle().
what is wrong with my kernel, plese give me some advice.thank you .


yours keng_629






keng_629
2007-10-15

--=====003_Dragon450500532701_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3157" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Verdana><FONT size=2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2>i am proting linux2.63.23 to mpc860t board 
with uboot1.1.4 as bootloader.</FONT></FONT></DIV>
<DIV><FONT face=Verdana size=2>my bootargs is root=/dev/ram rw 
init=/linuxrc.</FONT></DIV>
<DIV><FONT face=Verdana size=2>i use debugger to see the regedits, find pc is 
run in the cpu_idle().</FONT></DIV>
<DIV><FONT face=Verdana size=2>what is wrong with my kernel, plese give me some 
advice.thank you .</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2>yours keng_629</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana><FONT size=2></FONT>&nbsp;</DIV>
<DIV><FONT size=2></FONT>&nbsp;</DIV>
<DIV align=left><FONT size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" SIZE=2>
</FONT></DIV>
<DIV><FONT color=#c0c0c0><FONT size=2>keng_629</FONT></DIV>
<DIV><FONT size=2>2007-10-15</FONT></FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon450500532701_=====--
