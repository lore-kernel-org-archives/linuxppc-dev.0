Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s7.bay0.hotmail.com (bay0-omc2-s7.bay0.hotmail.com
	[65.54.246.143]) by ozlabs.org (Postfix) with ESMTP id 8EBF2DDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Apr 2008 18:10:09 +1000 (EST)
Message-ID: <BAY115-W320EEB76C566476D490D6B2E80@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_52acf9f6-c6bf-4c9a-a0ad-a660faef1888_"
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: XPS_LL_TEMAC works correctly?
Date: Mon, 14 Apr 2008 08:10:08 +0000
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_52acf9f6-c6bf-4c9a-a0ad-a660faef1888_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all,

Using:=20
EDK 9.2.02,=20
Xilinx Linux 2.6.24-rc8-xlnx
XPS_LL_TEMAC version 1.00.b

I bring up the Linux kernel on ML403 -Rev04 board,
LL_TEMAC buffer size 128kbits, and set to use SG DMA

I encounter the following messages when the kernel wants to mount the root =
file system, as one can see the kernel has mounter the nfs root file system=
 and init is initiated, but after that a Link carrier lost happens and it s=
tops working.=20

is this behavior natural? ( the PC has attansic gigabit ethernet port with =
kernel 2.6.24.4 running, nfs works very well in other tests)

thanks

.............
eth0: XLlTemac: speed set to 1000Mb/s
eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4
eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254
IP-Config: Complete:
      device=3Deth0, addr=3D10.10.10.11, mask=3D255.255.255.0, gw=3D10.10.1=
0.10,
     host=3D10.10.10.11, domain=3D, nis-domain=3D(none),
     bootserver=3D10.10.10.10, rootserver=3D10.10.10.10, rootpath=3D
Looking up port of RPC 100003/2 on 10.10.10.10
Looking up port of RPC 100005/1 on 10.10.10.10
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 88k init
eth0: XLlTemac: PHY Link carrier lost.
eth0: XLlTemac: speed set to 1000Mb/s
eth0: XLlTemac: PHY Link carrier restored.
( KERNEL STOPS WORKING HERE!!!!!!!!)



_________________________________________________________________
Try Chicktionary, a game that tests how many words you can form from the le=
tters given. Find this and more puzzles at Live Search Games!
http://g.msn.ca/ca55/207=

--_52acf9f6-c6bf-4c9a-a0ad-a660faef1888_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
Hi all,<br><br>Using: <br>EDK 9.2.02, <br>Xilinx Linux 2.6.24-rc8-xlnx<br>X=
PS_LL_TEMAC version 1.00.b<br><br>I bring up the Linux kernel on ML403 -Rev=
04 board,<br>LL_TEMAC buffer size 128kbits, and set to use SG DMA<br><br>I =
encounter the following messages when the kernel wants to mount the root fi=
le system, as one can see the kernel has mounter the nfs root file system a=
nd init is initiated, but after that a Link carrier lost happens and it sto=
ps working. <br><br>is this behavior natural? ( the PC has attansic gigabit=
 ethernet port with kernel 2.6.24.4 running, nfs works very well in other t=
ests)<br><br>thanks<br><br>.............<br>eth0: XLlTemac: speed set to 10=
00Mb/s<br>eth0: XLlTemac: Send Threshold =3D 24, Receive Threshold =3D 4<br=
>eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254<br>IP-=
Config: Complete:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3Deth0, addr=3D1=
0.10.10.11, mask=3D255.255.255.0, gw=3D10.10.10.10,<br>&nbsp;&nbsp;&nbsp;&n=
bsp; host=3D10.10.10.11, domain=3D, nis-domain=3D(none),<br>&nbsp;&nbsp;&nb=
sp;&nbsp; bootserver=3D10.10.10.10, rootserver=3D10.10.10.10, rootpath=3D<b=
r>Looking up port of RPC 100003/2 on 10.10.10.10<br>Looking up port of RPC =
100005/1 on 10.10.10.10<br>VFS: Mounted root (nfs filesystem).<br>Freeing u=
nused kernel memory: 88k init<br>eth0: XLlTemac: PHY Link carrier lost.<br>=
eth0: XLlTemac: speed set to 1000Mb/s<br>eth0: XLlTemac: PHY Link carrier r=
estored.<br>( KERNEL STOPS WORKING HERE!!!!!!!!)<br><br><br><br /><hr />Sig=
n in today. When you sign in to Windows Live Messenger you could win $1000 =
a day until May 12th. <a href=3D'http://g.msn.ca/ca55/209' target=3D'_new'>=
Learn more at SignInAndWIN.ca</a></body>
</html>=

--_52acf9f6-c6bf-4c9a-a0ad-a660faef1888_--
