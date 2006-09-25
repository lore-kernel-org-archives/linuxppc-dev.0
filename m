Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id C6A4A67B9E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 05:29:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E0D8.DB54A6E8"
Subject: Console Stops on NFS root startup
Date: Mon, 25 Sep 2006 15:29:01 -0400
Message-ID: <3C02138692C13C4BB675FE7EA24095291C46E6@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
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

------_=_NextPart_001_01C6E0D8.DB54A6E8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey guys,

I have a dev board based loosely off the MPC8540ADS that I am trying to
boot over NFS. After setting up the proper kernel configuration and
sharing the root filesystem over NFS, I boot up the board. Everything
loads up fine, and it even says it mounts the root filesystem, however
this is the output I get.

IP-Config: Complete:
      device=3Deth0, addr=3D204.215.226.251, mask=3D255.255.255.0,
gw=3D204.215.226.50,
     host=3D204.215.226.251, domain=3D, nis-domain=3D(none),
     bootserver=3D204.215.226.250, rootserver=3D204.215.226.250, =
rootpath=3D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 204.215.226.250
Looking up port of RPC 100005/1 on 204.215.226.250
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 236k init
=20
At this point, the serial console no longer displays or accepts input
from the keyboard. The system does not appear to hang, because when I
try to ping it from another point on the network, it responds. It seems
like either init is not executing at this point, or if the console is
being changed to another device. I wanted to know if anybody has had
this problem before. I tried building BusyBox as a static-linked binary,
which has not resolved the issue. I have also tried multiple root file
system builds, which has also not yielded a solution. Thanks for any
assistance with this.
=20
Clinton Thomas
=20

------_=_NextPart_001_01C6E0D8.DB54A6E8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D694302419-25092006><FONT face=3DArial size=3D2>Hey =
guys,<BR><BR>I=20
have a dev board based loosely off the MPC8540ADS that I am trying to =
boot over=20
NFS. After setting up the proper kernel configuration and sharing the =
root=20
filesystem over NFS, I boot up the board. Everything loads up fine, and =
it even=20
says it mounts the root filesystem, however this is the output I=20
get.<BR><BR><EM>IP-Config: Complete:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
device=3Deth0, addr=3D204.215.226.251, mask=3D255.255.255.0,=20
gw=3D204.215.226.50,<BR>&nbsp;&nbsp;&nbsp;&nbsp; host=3D204.215.226.251, =
domain=3D,=20
nis-domain=3D(none),<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
bootserver=3D204.215.226.250,=20
rootserver=3D204.215.226.250, rootpath=3D<BR>NET4: Unix domain sockets =
1.0/SMP for=20
Linux NET4.0.<BR>Looking up port of RPC 100003/2 on =
204.215.226.250<BR>Looking=20
up port of RPC 100005/1 on 204.215.226.250<BR>VFS: Mounted root (nfs=20
filesystem).<BR>Mounted devfs on /dev<BR>Freeing unused kernel memory: =
236k=20
init</EM></FONT></SPAN></DIV>
<DIV><SPAN class=3D694302419-25092006><EM><FONT face=3DArial=20
size=3D2></FONT></EM></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D694302419-25092006><FONT face=3DArial size=3D2>At =
this point, the=20
serial console no longer displays or accepts input from the keyboard. =
The system=20
does not appear to hang, because when I try to ping it from another =
point on the=20
network, it responds. It seems like either init is not executing at this =
point,=20
or if the console is being changed to another device. I wanted to know =
if=20
anybody has had this problem before. I tried building BusyBox as a =
static-linked=20
binary, which has not resolved the issue. I have also tried multiple =
root file=20
system builds, which has also not yielded a solution. Thanks for any =
assistance=20
with this.</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton =
Thomas</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6E0D8.DB54A6E8--
