Return-Path: <mike.koss@ngc.com>
Received: from xmrt0101.northgrum.com (xmrt0101.northgrum.com [208.20.220.55])
	by ozlabs.org (Postfix) with ESMTP id DDB09DDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 08:06:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B7A1.1EF790F3"
Subject: arch/powerpc, Xilinx, and mainline kernel support
Date: Fri, 16 May 2008 17:06:41 -0500
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C0B@XMBIL132.northgrum.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B7A1.1EF790F3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is there any reason why the mainline 2.6.25.3 (and from what I could see
.4) is missing the files to build for the Xilinx Virtex platform?

Or in other words, I tried to build from 2.6.25.3 for the Xilinx Virtex
under arch/powerpc (because arch/ppc actually crashes when once apps
start to run) and it failed when trying to actually create the zImage. I
hopped over to Xilinx's git server and noticed a bunch of missing
entries in the boot/Makefile and source code to actually support the
complete image build for a Xilinx Virtex PPC405.

When is the Xilinx Virtex support going to be mainline official? I need
to be able to grab a stable kernel and work from there rather than using
the latest -rc that Xilinx is hosting on their git server.

-- Mike

------_=_NextPart_001_01C8B7A1.1EF790F3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>arch/powerpc, Xilinx, and mainline kernel support</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Is there any reason why the mainline =
2.6.25.3 (and from what I could see .4) is missing the files to build =
for the Xilinx Virtex platform?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Or in other words, I tried to build =
from 2.6.25.3 for the Xilinx Virtex under arch/powerpc (because arch/ppc =
actually crashes when once apps start to run) and it failed when trying =
to actually create the zImage. I hopped over to Xilinx's git server and =
noticed a bunch of missing entries in the boot/Makefile and source code =
to actually support the complete image build for a Xilinx Virtex =
PPC405.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">When is the Xilinx Virtex support going =
to be mainline official? I need to be able to grab a stable kernel and =
work from there rather than using the latest -rc that Xilinx is hosting =
on their git server.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">-- Mike</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8B7A1.1EF790F3--
