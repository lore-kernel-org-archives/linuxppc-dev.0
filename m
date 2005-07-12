Return-Path: <d.flament@sofrel.com>
Received: from smtp14.clb.oleane.net (smtp14.clb.oleane.net [213.56.31.53])
	by ozlabs.org (Postfix) with ESMTP id BCA5367B9A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2005 00:37:46 +1000 (EST)
Received: from smtp14.clb.oleane.net (localhost [127.0.0.1])
	by smtp14.clb.oleane.net (antivirus) with ESMTP id j6CEbhiE000610
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 16:37:43 +0200
Received: from sof_msg.sofrel.local ([81.80.115.55])
	by smtp14.clb.oleane.net with ESMTP id j6CEbhcm000582
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2005 16:37:43 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C586EF.90FC93A8"
Date: Tue, 12 Jul 2005 16:39:53 +0200
Message-ID: <892C3EC180087B4498C69413FCCBB7320159AE59@sof_msg>
From: "FLAMENT David" <d.flament@sofrel.com>
To: <linuxppc-dev@ozlabs.org>
Subject: problem of load kernel after uncompressiong kernel Image ....
	(linuxppc 2.4.27)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C586EF.90FC93A8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear,
=20
    Here is my problems,

    OS: kernel 2.4.27 linuxppc-embedded
    platform: ppc rattler 8248
=20
    When I load a kernel image (uImage) with u-boot, the prompt of =
kernel is blocking
   =20
    boot args kernel parameters :=20
        "console=3DttyS0,38400n8 nfsroot=3D/tftpboot/ppc_root rw =
ip=3D192.168.1.23:192.168.1.21::::eth0:off"
=20
the screenshot of loading kernel :
    TFTP from server 192.168.1.21; our IP address is 192.168.1.23
    Filename 'uImage'.
    Load address: 0x100000
    Loading: =
#################################################################
    #################################################################
    ############################
    done
    Bytes transferred =3D 803951 (c446f hex)
    ## Booting image at 00100000 ...
    Image Name: Linux-2.4.27-pre1
    Image Type: PowerPC Linux Kernel Image (gzip compressed)
    Data Size: 803887 Bytes =3D 785 kB
    Load Address: 00000000
    Entry Point: 00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
=20
You can see, after uncompressing kernel, there are nothing !!!=20
I try to use another kernel 2.4.26 with the same nfsroot and boot =
parameters and I can ping my target but not with linuxppc 2.4.27.
If you have an idea about this problem !! thank's.
note : I use a rattler 8248 with a 2.4.27 linuxppc kernel
=20
Help me please !!!
=20
--------------------------------
Flament David
d.flament@sofrel.com
Lacroix Sofrel, 1 rue plessis, 35770 Vern sur seiche (France)
(+33)2.99.04.84.23
=20
=20

------_=_NextPart_001_01C586EF.90FC93A8
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D976042514-12072005>Dear,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D976042514-12072005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D976042514-12072005>&nbsp;&nbsp;&nbsp;=20
Here is my problems,<BR><BR>&nbsp;&nbsp;&nbsp; OS:&nbsp;<SPAN=20
class=3D154355807-12072005>kernel 2.4.27=20
linuxppc-embedded</SPAN><BR>&nbsp;&nbsp;&nbsp; platform: ppc&nbsp;<SPAN=20
class=3D154355807-12072005>rattler 8248</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><SPAN=20
class=3D154355807-12072005></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><SPAN=20
class=3D154355807-12072005>&nbsp;&nbsp;&nbsp; When I load a kernel image =
(uImage)=20
with u-boot, the prompt of kernel is blocking</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><SPAN=20
class=3D154355807-12072005>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><SPAN=20
class=3D154355807-12072005>&nbsp;&nbsp;&nbsp; boot args kernel =
parameters :=20
</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><SPAN=20
class=3D154355807-12072005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
"console=3DttyS0,38400n8 nfsroot=3D/tftpboot/ppc_root rw=20
ip=3D192.168.1.23:192.168.1.21::::eth0:off"</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><SPAN=20
class=3D154355807-12072005></SPAN>&nbsp;</DIV>
<DIV></SPAN></FONT><FONT face=3DArial size=3D2><SPAN =
class=3D976042514-12072005>the=20
screenshot of loading kernel :</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D976042514-12072005></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT =
size=3D2>&nbsp;&nbsp;&nbsp;=20
TFTP from server 192.168.1.21; our IP address is=20
192.168.1.23</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Filename =
'uImage'.</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Load address: =
0x100000</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Loading:=20
#################################################################</FONT><=
/SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;=20
#################################################################</FONT><=
/SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;=20
############################</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; done</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Bytes transferred =3D 803951 (c446f=20
hex)</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; ## Booting image at 00100000=20
...</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Image Name:=20
Linux-2.4.27-pre1</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Image Type: PowerPC Linux Kernel Image (gzip =

compressed)</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Data Size: 803887 Bytes =3D 785=20
kB</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Load Address: =
00000000</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Entry Point: =
00000000</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Verifying Checksum ... =
OK</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image ...=20
OK</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D976042514-12072005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005>You =
can see, after=20
uncompressing kernel, there are nothing !!! </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005>I try =
to use another=20
kernel 2.4.26 with the same nfsroot and boot parameters and I can ping =
my target=20
but not with linuxppc 2.4.27.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005>If you =
have an idea=20
about this problem !! thank's.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005>note : =
I use a=20
rattler 8248 with a 2.4.27 linuxppc kernel</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D976042514-12072005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005>Help =
me please=20
!!!</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D976042514-12072005><FONT=20
size=3D2>&nbsp;</DIV></FONT></SPAN></FONT>
<DIV><FONT face=3DArial =
size=3D2>--------------------------------</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Flament David</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"mailto:d.flament@sofrel.com">d.flament@sofrel.com</A></FONT></DIV=
>
<DIV><FONT face=3DArial size=3D2>Lacroix Sofrel, </FONT><FONT =
face=3DArial size=3D2>1=20
rue plessis, 35770 Vern sur seiche (France)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>(+33)2.99.04.84.23</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C586EF.90FC93A8--
