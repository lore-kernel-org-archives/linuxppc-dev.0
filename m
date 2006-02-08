Return-Path: <greg.buhler@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id E965F68A92
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 08:05:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C62CF1.AA4D0591"
Subject: Example PPC-4xx DMA scatter/gather usage
Date: Wed, 8 Feb 2006 12:53:25 -0800
Message-ID: <68997D3094017740BB875EB2A425A6EA02C1C11D@VCAEXCH01.hq.corp.viasat.com>
From: "Buhler, Greg" <greg.buhler@viasat.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C62CF1.AA4D0591
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Does anyone have any example code they could provide me that shows
correct usage of the Linux 2.6.x PPC-4xx scatter/gather DMA
functionality? None of the mainline kernel tree sources or module
sources seem to use this functionality.=20

I am working on a driver that runs on an embedded PPC-405gp running
linux 2.4.21.  The driver relies extensively on the PPC's DMA controller
using all 4 channels simultaneously.  After some research I determined
that the version of the dma code that was in 2.4.21 had been
significantly modified in more recent kernel trees. As a result I have
merged in the 2.6.x version of this code, but am running into some
trouble with sg transfers.  Specifically, after setting up an sgl the
way I used to with the 2.4.21 kernel, and then kicking off the transfer,
nothing seems to get transferred. When I attempt to remove sg elements
from the sgl, the kernel complains saying that I'm trying to remove an
element from an already empty sgl.

Any help, advice, or examples would be greatly appreciated. Thanks.
______________________
Greg Buhler
Embedded INFOSEC Systems
Network Systems Group
ViaSat, Inc
760.476.2699
greg.buhler@viasat.com


------_=_NextPart_001_01C62CF1.AA4D0591
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7232.68">
<TITLE>Example PPC-4xx DMA scatter/gather usage</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Does =
anyone have any example code they could provide me that shows correct =
usage of the Linux 2.6.x PPC-4xx scatter/</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">ga</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">ther DMA =
functionality?</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">None of the mainline =
kernel tree sources or module sources seem to use this =
functionality.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> </SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I am =
working on a driver that runs</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> on an embedded PPC-405gp running linux =
2.4.21</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">.&nbsp; The driver relies =
extensively on the PPC</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">s DMA controller</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">using</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">all 4 channels =
simultaneously.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us">&nbsp;<FONT SIZE=3D2 =
FACE=3D"Arial"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">After some research I =
determined that the version of the</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">dma</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> code that was in 2.4.21 =
had been significantly modified in more recent kernel trees. As a result =
I have merged in the 2.6.x version of this code, but am running into =
some trouble with sg transfers.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp; Specifically, after setting up =
a</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">n</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> sgl</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"> the way I used to with the 2.4.21 kernel, and then =
kicking off the transfer, nothing seems to get</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">transferred</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> When I attempt to remove =
sg elements from the sgl, the kernel complains saying that =
I</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">m trying to remove an element from an already empty =
sgl.</FONT></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Any =
help, advice, or examples would be greatly appreciated. =
Thanks.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"></SPAN><A NAME=3D""><SPAN =
LANG=3D"en-us"><FONT COLOR=3D"#808080" SIZE=3D2 =
FACE=3D"Arial">______________________</FONT></SPAN></A><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><B><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000080" SIZE=3D2 =
FACE=3D"Arial">Greg Buhler</FONT></SPAN></B><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><I><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000080" SIZE=3D2 =
FACE=3D"Arial">Embedded INFOSEC Systems</FONT></SPAN></I><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><I><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000080" SIZE=3D2 =
FACE=3D"Arial">Network Systems Group</FONT></SPAN></I><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><I><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000080" SIZE=3D2 =
FACE=3D"Arial">ViaSat, Inc</FONT></SPAN></I><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000080" SIZE=3D2 =
FACE=3D"Arial">760.476.2699</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P ALIGN=3DLEFT><SPAN LANG=3D"en-us"><FONT COLOR=3D"#000080" SIZE=3D2 =
FACE=3D"Arial">greg.buhler@viasat.com</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C62CF1.AA4D0591--
