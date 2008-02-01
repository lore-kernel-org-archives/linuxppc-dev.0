Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 60C45DDF8F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 10:23:23 +1100 (EST)
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m11NNMUr002443
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Feb 2008 15:23:22 -0800
Received: from xbh-sjc-231.amer.cisco.com (xbh-sjc-231.cisco.com
	[128.107.191.100])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id m11NNL1l010692
	for <linuxppc-embedded@ozlabs.org>; Fri, 1 Feb 2008 23:23:22 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C86529.6F39C530"
Subject: build is broken
Date: Fri, 1 Feb 2008 15:23:21 -0800
Message-ID: <F795765B112E7344AF36AA911279641502D1AA28@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
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

------_=_NextPart_001_01C86529.6F39C530
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi=20
I just downloaded the latest source tree from :
git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

I am using gnu cross compiler version 3.4.3. I get the an "awk" and
"assmbeler" error.

Please help me out. Thanks

$ <mailto:bizhan@PPC]$>  make ARCH=3Dpowerpc
CROSS_COMPILE=3Dpowerpc-linux-gnu- uImage
awk: cmd. line:1: (FILENAME=3D- FNR=3D2) fatal: attempt to access field =
-1
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CALL    arch/powerpc/kernel/systbl_chk.sh
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.meminit.text+0x9f8): Section mismatch in reference
from the function free_area_init_node() to the function
.init.text:__alloc_bootmem_node()
The function __meminit free_area_init_node() references
a function __init __alloc_bootmem_node().
If free_area_init_node is only used by __alloc_bootmem_node then
annotate free_area_init_node with a matching annotation.
=20
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  BOOTCC  arch/powerpc/boot/treeboot-walnut.o
Assembler messages:
Error: Internal assembler error for instruction icbt
Internal error, aborting at
/usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c
line 1300 in ppc_setup_opcodes
Please report this bug.
make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
make: *** [uImage] Error 2


------_=_NextPart_001_01C86529.6F39C530
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3243" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D609291923-01022008>Hi=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D609291923-01022008>I just =
downloaded=20
the latest source tree from :</SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D609291923-01022008>
<P><FONT face=3DArial=20
size=3D2>git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git=
</FONT></P>
<P><SPAN class=3D609291923-01022008><FONT face=3DArial size=3D2>I am =
using gnu cross=20
compiler version 3.4.3. I get the&nbsp;an "awk"=20
and&nbsp;"assmbeler"&nbsp;error.</FONT></SPAN></P>
<P><SPAN class=3D609291923-01022008><FONT face=3DArial size=3D2>Please =
help me out.=20
Thanks</FONT></SPAN></P></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A href=3D"mailto:bizhan@PPC]$">$</A> =
make=20
ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu- uImage<BR>awk: cmd. =
line:1:=20
(FILENAME=3D- FNR=3D2) fatal: attempt to access field -1<BR>&nbsp;=20
CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<BR>&nbsp;=20
CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/utsrelease.h<BR>&nbsp;=20
CALL&nbsp;&nbsp;&nbsp; scripts/checksyscalls.sh<BR>&nbsp;=20
CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<BR>&nbsp;=20
CALL&nbsp;&nbsp;&nbsp; arch/powerpc/kernel/systbl_chk.sh<BR>&nbsp;=20
LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmlinux.o<BR>&nbsp; MODPOST=20
vmlinux.o<BR>WARNING: vmlinux.o(.meminit.text+0x9f8): Section mismatch =
in=20
reference from the function free_area_init_node() to the function=20
.init.text:__alloc_bootmem_node()<BR>The function __meminit=20
free_area_init_node() references<BR>a function __init=20
__alloc_bootmem_node().<BR>If free_area_init_node is only used by=20
__alloc_bootmem_node then<BR>annotate free_area_init_node with a =
matching=20
annotation.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp; AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

.tmp_kallsyms2.o<BR>&nbsp; LD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vmlinux<BR>&nbsp;=20
SYSMAP&nbsp; System.map<BR>&nbsp; SYSMAP&nbsp; .tmp_System.map<BR>&nbsp; =

BOOTCC&nbsp; arch/powerpc/boot/treeboot-walnut.o<BR>Assembler=20
messages:<BR>Error: Internal assembler error for instruction =
icbt<BR>Internal=20
error, aborting at=20
/usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c =
line 1300=20
in ppc_setup_opcodes<BR>Please report this bug.<BR>make[1]: ***=20
[arch/powerpc/boot/treeboot-walnut.o] Error 2<BR>make: *** [uImage] =
Error=20
2<BR></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C86529.6F39C530--
