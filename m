Return-Path: <hangtoo@163.com>
Received: from m5-81.163.com (m5-81.163.com [202.108.5.81])
	by ozlabs.org (Postfix) with SMTP id D90AEDDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 12:33:17 +1100 (EST)
Date: Tue, 8 Jan 2008 09:18:23 +0800
From: "tony" <hangtoo@163.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: Re:How to config linux kernel(ARCH=powerpc)?
Message-ID: <200801080918222817608@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon721813537465_====="
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

--=====003_Dragon721813537465_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

hi Jie
maybe you should try it like this:
linux-2.6-denx->make ARCH=ppc CROSS_COMPILE=ppc_4xx- pasemi_defconfig
make sure you have installed the ppc_4xx- tools.
good luck

tony

               

--=====003_Dragon721813537465_=====
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
<BODY>
<DIV>hi Jie</DIV>
<DIV style="TEXT-INDENT: 2em">maybe you should&nbsp;try it like this:</DIV>
<DIV style="TEXT-INDENT: 2em">linux-2.6-denx-&gt;make ARCH=ppc 
CROSS_COMPILE=ppc_4xx-&nbsp;pasemi_defconfig</DIV>
<DIV style="TEXT-INDENT: 2em">make sure you have installed the ppc_4xx- 
tools.</DIV>
<DIV style="TEXT-INDENT: 2em">good luck</DIV>
<DIV style="TEXT-INDENT: 2em">&nbsp;</DIV>
<DIV style="TEXT-INDENT: 2em">tony</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV></BODY></HTML>

--=====003_Dragon721813537465_=====--
