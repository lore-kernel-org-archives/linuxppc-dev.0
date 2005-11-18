Return-Path: <soumya.k.s@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 0C0B5687A3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 18:08:16 +1100 (EST)
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id jAI7Klv4013054
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 00:20:47 -0700 (MST)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id jAI7JBgV021709
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 01:19:12 -0600 (CST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5EC0E.8BC2BDA9"
Date: Fri, 18 Nov 2005 15:06:06 +0800
Message-ID: <C82A9B11BE247C4E952DC733EA98DAA1329D29@ZMY16EXM66.ds.mot.com>
From: "KS Soumya-ask067" <soumya.k.s@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Insmod mod.ko: ERROR: Module mod does not exist in /proc/modules
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

------_=_NextPart_001_01C5EC0E.8BC2BDA9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am using Linux 2.6.10 for an MPC8540 board.
 "insmod" seemed to have a problem which said=20
[insmod: QM_MODULES: Function not implemented] .=20
After googling, I downloaded the module-init-tools 3.1, cross compiled
it with 85xx tool chain, installed it on the target filesystem.=20
=20
Now after doing that, I get an error,
=20
ERROR: Module mod does not exist in /proc/modules
=20
I have enabled the Module loading/unloading option in the kernel. Am I
missing out on anything else?
=20
Can anyone please help me with a lead. A snapshot of the error is
attached.
=20
Thanks a lot,
Soumya

10 login: root
Last login: Wed Dec 31 19:00:49 on console
bash-2.05b#
bash-2.05b#
bash-2.05b# insmod mod.ko
ERROR: Module mod does not exist in /proc/modules
bash-2.05b#
bash-2.05b#
bash-2.05b# insmod -f mod.ko
ERROR: Removing 'mod': No such file or directory
bash-2.05b#
bash-2.05b#
bash-2.05b# modprobe mod.ko
ERROR: Module mod does not exist in /proc/modules
bash-2.05b#
bash-2.05b# lsmod mod
ERROR: Module mod does not exist in /proc/modules
bash-2.05b#
bash-2.05b#
bash-2.05b# insmod -V
module-init-tools version 3.1
bash-2.05b#

=20
=20
=20

------_=_NextPart_001_01C5EC0E.8BC2BDA9
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1515" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D028533506-18112005>I am =
using Linux=20
2.6.10 for an MPC8540 board.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D028533506-18112005>&nbsp;"insmod"=20
seemed to have a problem which said </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D028533506-18112005>[insmod: QM_MODULES:=20
Function not implemented] .&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D028533506-18112005>After =
googling, I=20
downloaded the module-init-tools 3.1, cross compiled it with 85xx tool =
chain,=20
installed it on the target filesystem. </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D028533506-18112005>Now =
after doing=20
that, I get an error,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D028533506-18112005><STRONG>ERROR:=20
Module mod does not exist in /proc/modules</STRONG></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D028533506-18112005>I have =
enabled the=20
Module loading/unloading option in the kernel. Am I missing out on =
anything=20
else?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D028533506-18112005>Can =
anyone please=20
help me with a lead.&nbsp;A snapshot of the error is=20
attached.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D028533506-18112005>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D028533506-18112005>Thanks =
a=20
lot,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005>Soumya</SPAN></FONT></DIV></SPAN></FONT></DIV>=
<FONT=20
face=3DArial size=3D2><SPAN class=3D028533506-18112005>
<DIV><BR>10 login: root<BR>Last login: Wed Dec 31 19:00:49 on=20
console<BR>bash-2.05b#<BR>bash-2.05b#<BR>bash-2.05b# insmod=20
mod.ko<BR><STRONG>ERROR: Module mod does not exist in=20
/proc/modules<BR></STRONG>bash-2.05b#<BR>bash-2.05b#<BR>bash-2.05b# =
insmod -f=20
mod.ko<BR>ERROR: Removing 'mod': No such file or=20
directory<BR>bash-2.05b#<BR>bash-2.05b#<BR>bash-2.05b# modprobe =
mod.ko<BR>ERROR:=20
Module mod does not exist in /proc/modules<BR>bash-2.05b#<BR>bash-2.05b# =
lsmod=20
mod<BR>ERROR: Module mod does not exist in=20
/proc/modules<BR>bash-2.05b#<BR>bash-2.05b#<BR>bash-2.05b# insmod=20
-V<BR>module-init-tools version 3.1</DIV>
<DIV>bash-2.05b#<BR></DIV>
<DIV></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D028533506-18112005></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C5EC0E.8BC2BDA9--
