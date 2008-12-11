Return-Path: <maillist.kernel@gmail.com>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.247])
	by ozlabs.org (Postfix) with ESMTP id 91F5EDDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 23:04:20 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so1096808agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 04:04:18 -0800 (PST)
Date: Thu, 11 Dec 2008 20:04:14 +0800
From: "maillist.kernel" <maillist.kernel@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: How to support 3GB pci address?
Message-ID: <200812112004118902765@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon652578677326_====="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

--=====003_Dragon652578677326_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi, we want to design a system using mpc8548, and linking with an idt 16 ports PCIE switch.
In the system, the total PCI address needed is about 3GB, so I want to know how to support it in linux. mpc8548 has 36-bit real address, and can support 32GB PCIE address space, but in linux, there is only 1GB kernel space, how to map the 3GB pci address to kernel? Is the  36-bit real address only used to support large memory(>4GB) for muti-threads? 

Any suggestions please would be much appreciated!

Thanks in advance for your help

 

--=====003_Dragon652578677326_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.3462" name=GENERATOR>
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
<DIV><FONT face=Verdana><FONT face=Verdana color=#c0c0c0><FONT color=#000000 
size=5>Hi,&nbsp;we want to design a system using mpc8548, and linking with an 
idt 16 ports&nbsp;PCIE switch.</FONT></FONT></FONT></DIV>
<DIV><FONT size=5><FONT face=Verdana>In&nbsp;the system, the total&nbsp;PCI 
address&nbsp;needed is about 3GB, so I want to know how to support it in linux. 
mpc8548 has 36-bit real address, and can support 32GB&nbsp;PCIE address space, 
but in linux, there is only 1GB kernel space, how to map the 3GB pci address to 
kernel? Is the&nbsp;</FONT>&nbsp;36-bit real address only used to&nbsp;support 
large memory(&gt;4GB) for muti-threads?&nbsp;</FONT></DIV>
<DIV><FONT size=5></FONT>&nbsp;</DIV>
<DIV><FONT size=5>Any suggestions please would be much appreciated!</FONT></DIV>
<DIV><FONT size=5></FONT>&nbsp;</DIV>
<DIV>
<H3 class=r><FONT size=5>Thanks in advance for your help</FONT></H3></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2>&nbsp;</DIV></FONT></BODY></HTML>

--=====003_Dragon652578677326_=====--
