Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id AABF267EE3
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Aug 2005 11:18:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5995A.99CD5326"
Date: Fri, 5 Aug 2005 09:11:25 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E865055@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <galak@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: The kernel halt after "transferring control to linux(0x000000)..."
	on HD860(MPC860SR) board kernel 2.4.25,and 2.6.12
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5995A.99CD5326
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Dear Gala:
  I meet a problem when porting kernel  2.4.25,and 2.6.12 to a HD860 =
board: Whatever your config, or whatever you patch, set ppcboot =
enviroment,=20
  whether use ramdisk or nfs, the kernel  all display a message then =
halt.
  "transferring control to linux (0x000000) ..."
  The log_buf in Memory display that the kernel has problem at :=20

  1. /init/main.c  calibrate_delay() ;
  2. /init/main.c  do_initcalls() do while dead loop!!=20
  3. /init/do_mounts.c mount_root()=20
=20
 Does it need any patches? thanks!
 The kernel 2.4.25 is from ELDK 3.1.1, 2.6.12.3 is from kernel.org
 =20

 =20


------_=_NextPart_001_01C5995A.99CD5326
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6603.0">
<TITLE>The kernel halt after &quot;transferring control to =
linux(0x000000)...&quot; on HD860(MPC860SR) board kernel 2.4.25,and =
2.6.12</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">Dear =
Gala:</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; I meet a =
problem when porting kernel&nbsp; 2.4.25,and 2.6.12 to a HD860 board: =
Whatever your config, or whatever you patch, set ppcboot enviroment, =
</FONT></SPAN></P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; whether use =
ramdisk or nfs, the kernel&nbsp; all display a message then =
halt.</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; =
&quot;transferring control to linux (0x000000) ...&quot;</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; The =
log_buf in Memory display that the kernel has problem at : =
</FONT></SPAN>
</P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; 1. =
/init/main.c&nbsp; calibrate_delay() ;</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; 2. =
/init/main.c&nbsp; do_initcalls() do while dead loop!! </FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; 3. =
/init/do_mounts.c mount_root() </FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;Does it =
need any patches? thanks!</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;The kernel =
2.4.25 is from ELDK 3.1.1, 2.6.12.3 is from kernel.org</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; =
</FONT></SPAN>
</P>

<P><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Arial">&nbsp; =
</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C5995A.99CD5326--
