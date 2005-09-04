Return-Path: <mqy@263.net.cn>
From: "KylongMu" <mqy@263.net.cn>
To: <Linuxppc-embedded@ozlabs.org>
Date: Sun, 4 Sep 2005 23:50:49 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C5B1AB.7AE8D390"
Message-Id: <20050904155104.C5E13C19@smtp.263.net>
Subject: Promise Ultra 100 TX2 20268 chip receive "lost interrupt" error
	under 2.6.13 (ppc8540ads platform)
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

------=_NextPart_000_0000_01C5B1AB.7AE8D390
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi, team:
 
Kernel version: 2.6.13 (stable version)
Platform type : ppc8540ads platform
Problem hardware type: Promise20268 PCI-ATA card
Configuration:
configured ATA support with these  part : Device driver, File
system,Partition table.
Problem description:
     When I boot my board, the kernel can recognize my Promise20268 card,
and my
SegateHD correctly. but prompt with "lost interrupt" message.
    After boot procedure, the /proc/partitions file shows correct partitions
info, but when
I mount my HD , I get "lost interrupt" message again, and the mount failed.
    Pls help me to solved this problem, or a suggestion to change with
another PCI-ATA chip which
had been tested.
 
Cordially,
KylongMu
    
 

------=_NextPart_000_0000_01C5B1AB.7AE8D390
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2722" name=3DGENERATOR></HEAD>
<BODY>
<DIV><!-- Converted from text/plain format --><FONT =
face=3D'"&#23435;&#20307;"'=20
color=3D#003f1e>Hi, team:</FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e><STRONG>Kernel =
version:</STRONG> 2.6.13 (stable=20
version)</FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e><STRONG>Platform =
type&nbsp;:</STRONG>=20
ppc8540ads platform</FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e><STRONG>Problem =
hardware type:</STRONG>=20
Promise20268 PCI-ATA card</FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; =
color=3D#003f1e><STRONG>Configuration:</STRONG></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e>
<DIV><FONT color=3D#003f1e>configured ATA support&nbsp;with these&nbsp;=20
part&nbsp;: Device driver, File system,</FONT><FONT =
color=3D#003f1e>Partition=20
table.</FONT></DIV></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e><STRONG>Problem=20
description:</STRONG></FONT></DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; <FONT color=3D#003f1e>When I boot my =
board, the=20
kernel can recognize my Promise20268 card, and my</FONT></DIV>
<DIV><FONT color=3D#003f1e>SegateHD </FONT><FONT =
color=3D#003f1e>correctly. but=20
prompt with "lost interrupt" message.</FONT></DIV>
<DIV>&nbsp;&nbsp;&nbsp; <FONT color=3D#003f1e>After boot =
procedure,&nbsp;the=20
/proc/partitions file shows correct partitions info, but =
when</FONT></DIV>
<DIV><FONT color=3D#003f1e>I mount my HD , I get "lost interrupt" =
message again,=20
and the mount failed.</FONT></DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;Pls help me to<FONT=20
color=3D#003f1e>&nbsp;solved&nbsp;this problem, or a suggestion to =
change with=20
another <FONT face=3D&#23435;&#20307;>PCI-ATA chip =
which</FONT></FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e>had been =
tested.</FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#23435;&#20307; =
color=3D#003f1e>Cordially,</FONT></DIV>
<DIV><FONT face=3D&#23435;&#20307; color=3D#003f1e>KylongMu</FONT></DIV>
<DIV>&nbsp;&nbsp;&nbsp; </DIV>
<DIV><FONT color=3D#003f1e></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0000_01C5B1AB.7AE8D390--
