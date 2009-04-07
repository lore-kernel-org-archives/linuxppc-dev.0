Return-Path: <sunijsur@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-5.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 805BBDE090
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 04:29:51 +1000 (EST)
Received: from sj-core-5.cisco.com (sj-core-5.cisco.com [171.71.177.238])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id n37II7JP019568
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 11:18:07 -0700
Received: from sj-webmail-9.cisco.com (sj-webmail-9.cisco.com [171.71.183.158])
	by sj-core-5.cisco.com (8.13.8/8.13.8) with ESMTP id n37II7hS013626
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 18:18:07 GMT
Received: from sj-webmail-9.cisco.com (localhost.localdomain [127.0.0.1])
	by sj-webmail-9.cisco.com (8.13.1/8.13.1) with ESMTP id n37II7Bx003084
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 11:18:07 -0700
Received: from sj-webmail-9 (root@localhost)
	by sj-webmail-9.cisco.com (8.13.1/8.13.1/Submit) with ESMTP id
	n37II6L1003082
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 11:18:07 -0700
Date: Tue, 7 Apr 2009 11:18:06 -0700
From: Subodh Nijsure <sunijsur@cisco.com>
To: <linuxppc-dev@ozlabs.org>
Message-ID: <00ba01c9b7ad$32dae000$d151150a@cisco.com>
Subject: Printk time stamp seems to be stuck.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00BB_01C9B772.867C0800"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_NextPart_000_00BB_01C9B772.867C0800
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline

I  am running PPC kernel (2.6.26) with .config that contains
CONFIG_PRINTK_TIME=y also I am booting kernel with parameter printk.time=1. 
I am also booting the kernel with option initcall_debug and I see following
output after setup_vmstat() the printk timestamp feature stops working. 
i.e. after call to setup_vmstat all printk messages have same timestamp...
 
 
[    4.294855] calling  pdflush_init+0x0/0x28()
[    4.294926] initcall pdflush_init+0x0/0x28() returned 0 after 0 msecs
[    4.294931] calling  kswapd_init+0x0/0x2c()
[    4.294962] initcall kswapd_init+0x0/0x2c() returned 0 after 0 msecs
[    4.294966] calling  setup_vmstat+0x0/0x74()
[    4.294966] initcall setup_vmstat+0x0/0x74() returned 0 after 0 msecs
[    4.294966] calling  init_emergency_pool+0x0/0x84()
[    4.294966] highmem bounce pool size: 64 pages
 
Has anybody else seen this or there is something odd with my kernel/board
setup.


/Subodh Nijsure

------=_NextPart_000_00BB_01C9B772.867C0800
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D402371118-07042009>I&nbsp;=
 am running=20
PPC kernel (2.6.26) with .config that contains </SPAN></FONT><FONT face=3D=
Arial=20
size=3D2><SPAN class=3D402371118-07042009>CONFIG_PRINTK_TIME=3Dy also I a=
m booting=20
kernel with parameter  printk.time=3D1. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D402371118-07042009>I am al=
so booting=20
the kernel with option initcall_debug and I see following output after=20
setup_vmstat() the printk timestamp feature stops </SPAN></FONT><FONT fac=
e=3DArial=20
size=3D2><SPAN class=3D402371118-07042009>working. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D402371118-07042009>i.e. af=
ter call to=20
setup_vmstat all printk messages have same timestamp...</SPAN></FONT></DI=
V>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D402371118-07042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D402371118-07042009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>[&nbsp;&nbsp;&nbsp; 4.294855] calling&nb=
sp;=20
pdflush_init+0x0/0x28()<BR>[&nbsp;&nbsp;&nbsp; 4.294926] initcall=20
pdflush_init+0x0/0x28() returned 0 after 0 msecs<BR>[&nbsp;&nbsp;&nbsp;=20
4.294931] calling&nbsp; kswapd_init+0x0/0x2c()<BR>[&nbsp;&nbsp;&nbsp; 4.2=
94962]=20
initcall kswapd_init+0x0/0x2c() returned 0 after 0 msecs<BR>[&nbsp;&nbsp;=
&nbsp;=20
4.294966] calling&nbsp; setup_vmstat+0x0/0x74()<BR>[&nbsp;&nbsp;&nbsp; 4.=
294966]=20
initcall setup_vmstat+0x0/0x74() returned 0 after 0 msecs<BR>[&nbsp;&nbsp=
;&nbsp;=20
4.294966] calling&nbsp; init_emergency_pool+0x0/0x84()<BR>[&nbsp;&nbsp;&n=
bsp;=20
4.294966] highmem bounce pool size: 64 pages</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D402371118-07042009><FONT face=3DArial size=3D2>Has any=
body else=20
seen this or there is something odd with my kernel/board=20
setup.</FONT></SPAN></DIV>
<DIV><FONT face=3DArial><BR><FONT size=3D2></FONT></FONT></DIV>
<DIV><SPAN class=3D402371118-07042009><FONT face=3DArial size=3D2>/Subodh=
=20
Nijsure</FONT></SPAN></DIV></BODY></HTML>

------=_NextPart_000_00BB_01C9B772.867C0800--
