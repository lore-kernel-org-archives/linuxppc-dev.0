Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 4B55467BCD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 07:11:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6C6F8.BF57424C"
Subject: PCI resource allocation MPC8540ADS
Date: Wed, 23 Aug 2006 17:11:48 -0400
Message-ID: <3C02138692C13C4BB675FE7EA240952918DFB7@bluefin.Soneticom.local>
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

------_=_NextPart_001_01C6C6F8.BF57424C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey guys,

I have a development board based loosely off the MPC8540ADS design that
I am trying to move to the Linux kernel 2.6. I already have this system
working successfully in Linux Kernel 2.4, but after dealing with
compilation and load errors, i've come to the point where I can get to a
console. However, this problem at boot time keeps me from using a lot of
onboard hardware. When I enable PCI support in the Kernel configuration,
this is the text I get at boot time...

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: bridge 1 resource 2 moved to 9ff00000..9fffffff
PCI: Cannot allocate resource region 1 of PCI bridge 2
PCI: Cannot allocate resource region 2 of PCI bridge 2
PCI: bridge 2 resource 2 moved to 9fe00000..9fefffff
PCI: Cannot allocate resource region 1 of device 0000:00:14.0
PCI: Cannot allocate resource region 2 of device 0000:00:14.0
PCI: Cannot allocate resource region 0 of device 0000:01:01.0
PCI: Cannot allocate resource region 1 of device 0000:01:01.0
PCI: Cannot allocate resource region 2 of device 0000:01:01.0
PCI: Cannot allocate resource region 0 of device 0000:01:05.0
PCI: Cannot allocate resource region 1 of device 0000:01:05.0
PCI: Cannot allocate resource region 2 of device 0000:01:05.0
PCI: Cannot allocate resource region 0 of device 0000:01:06.0
PCI: Cannot allocate resource region 0 of device 0000:01:06.1
PCI: Cannot allocate resource region 0 of device 0000:01:06.2
PCI: Failed to allocate mem resource #0:1000000@0 for 0000:01:01.0
PCI: Failed to allocate I/O resource #1:100@1000 for 0000:01:01.0
PCI: Failed to allocate mem resource #2:1000@0 for 0000:01:01.0
PCI: Failed to allocate mem resource #0:10000@0 for 0000:01:05.0
PCI: Failed to allocate mem resource #2:10000@0 for 0000:01:05.0
PCI: Failed to allocate mem resource #0:1000@0 for 0000:01:06.0
PCI: Failed to allocate mem resource #0:1000@0 for 0000:01:06.1
PCI: Failed to allocate mem resource #0:100@0 for 0000:01:06.2
=20
the system is using a PLX PCI bridge chip. Like I said, this works fine
in my 2.4 distribution. Thanks for any and all help!
=20
Clinton Thomas
cthomas@soneticom.com
=20

------_=_NextPart_001_01C6C6F8.BF57424C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D921420821-23082006><FONT face=3DArial size=3D2>Hey =
guys,<BR><BR>I=20
have a development board based loosely off the MPC8540ADS design that I =
am=20
trying to move to the Linux kernel 2.6. I already have this system =
working=20
successfully in Linux Kernel 2.4, but after dealing with compilation and =
load=20
errors, i've come to the point where I can get to a console. However, =
this=20
problem at boot time keeps me from using&nbsp;a&nbsp;lot of onboard =
hardware.=20
When I enable PCI support in the Kernel configuration, this is the text =
I get at=20
boot time...<BR><BR>PCI: Probing PCI hardware<BR>PCI: Cannot allocate =
resource=20
region 1 of PCI bridge 1<BR>PCI: Cannot allocate resource region 2 of =
PCI bridge=20
1<BR>PCI: bridge 1 resource 2 moved to 9ff00000..9fffffff<BR>PCI: Cannot =

allocate resource region 1 of PCI bridge 2<BR>PCI: Cannot allocate =
resource=20
region 2 of PCI bridge 2<BR>PCI: bridge 2 resource 2 moved to=20
9fe00000..9fefffff<BR>PCI: Cannot allocate resource region 1 of device=20
0000:00:14.0<BR>PCI: Cannot allocate resource region 2 of device=20
0000:00:14.0<BR>PCI: Cannot allocate resource region 0 of device=20
0000:01:01.0<BR>PCI: Cannot allocate resource region 1 of device=20
0000:01:01.0<BR>PCI: Cannot allocate resource region 2 of device=20
0000:01:01.0<BR>PCI: Cannot allocate resource region 0 of device=20
0000:01:05.0<BR>PCI: Cannot allocate resource region 1 of device=20
0000:01:05.0<BR>PCI: Cannot allocate resource region 2 of device=20
0000:01:05.0<BR>PCI: Cannot allocate resource region 0 of device=20
0000:01:06.0<BR>PCI: Cannot allocate resource region 0 of device=20
0000:01:06.1<BR>PCI: Cannot allocate resource region 0 of device=20
0000:01:06.2<BR>PCI: Failed to allocate mem resource #0:1000000@0 for=20
0000:01:01.0<BR>PCI: Failed to allocate I/O resource #1:100@1000 for=20
0000:01:01.0<BR>PCI: Failed to allocate mem resource #2:1000@0 for=20
0000:01:01.0<BR>PCI: Failed to allocate mem resource #0:10000@0 for=20
0000:01:05.0<BR>PCI: Failed to allocate mem resource #2:10000@0 for=20
0000:01:05.0<BR>PCI: Failed to allocate mem resource #0:1000@0 for=20
0000:01:06.0<BR>PCI: Failed to allocate mem resource #0:1000@0 for=20
0000:01:06.1<BR>PCI: Failed to allocate mem resource #0:100@0 for=20
0000:01:06.2</FONT></SPAN></DIV>
<DIV><SPAN class=3D921420821-23082006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D921420821-23082006><FONT face=3DArial size=3D2>the =
system is using=20
a PLX PCI bridge chip. Like I said, this works fine in my 2.4 =
distribution.=20
Thanks for any and all help!</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton=20
Thomas<BR>cthomas@soneticom.com</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6C6F8.BF57424C--
