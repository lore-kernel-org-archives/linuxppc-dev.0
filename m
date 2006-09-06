Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 5CB5767B95
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 07:08:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6D1F8.91EEED14"
Subject: Continuous Login Loop
Date: Wed, 6 Sep 2006 17:08:14 -0400
Message-ID: <3C02138692C13C4BB675FE7EA24095291C3C92@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: Jason Lamb <JLamb@Soneticom.com>
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

------_=_NextPart_001_01C6D1F8.91EEED14
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hey,

I'm running the latest kernel pull from the mvista powerpc 2.4 dev
source. I built a root file system using Busybox 1.2.0 and the mkrootfs
script by Wolfgang Klingauf (removed all DOS carriage returns). When the
system boots up, i'm getting this output.

Mounted devfs on /dev
Freeing unused kernel memory: 44k init
init started:  BusyBox v1.2.0 (2006.09.06-19:44+0000) multi-call binary
Starting pid 10, console /dev/console: '/etc/init.d/rcS'
Bummer, could not run '/etc/
PowerPC Linux 2.4.26
(none) login: root
Process '/sbin/getty 38400 tts/0' (pid 11) exited.  Scheduling i
PowerPC Linux 2.4.26
(none) login:
=20
it keeps looping through the login every time I try to enter root. I
have the root user in the passwd file, and I believe I have the RFS
setup properly. What would cause this kind of an issue? Is this a
problem related to getty? or just a missing file or device of some kind?
Thanks

=20
Clinton Thomas
=20

------_=_NextPart_001_01C6D1F8.91EEED14
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D900560021-06092006>Hey,<BR><BR>I'm=20
running the latest kernel pull from the mvista powerpc 2.4 dev source. I =
built a=20
root file system using Busybox 1.2.0 and the mkrootfs script by Wolfgang =

Klingauf (removed all DOS carriage returns). When the system boots up, =
i'm=20
getting this output.<BR><BR><EM>Mounted devfs on /dev<BR>Freeing unused =
kernel=20
memory: 44k init<BR>init started:&nbsp; BusyBox v1.2.0 =
(2006.09.06-19:44+0000)=20
multi-call binary<BR>Starting pid 10, console /dev/console:=20
'/etc/init.d/rcS'<BR>Bummer, could not run '/etc/<BR>PowerPC Linux=20
2.4.26<BR>(none) login: root<BR>Process '/sbin/getty 38400 tts/0' (pid =
11)=20
exited.&nbsp; Scheduling i<BR>PowerPC Linux 2.4.26<BR>(none)=20
login:</EM></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D900560021-06092006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D900560021-06092006>it =
keeps looping=20
through the login every time I try to enter root. I have the root user =
in the=20
<EM>passwd</EM> file, and I believe I have the RFS setup properly. What =
would=20
cause this kind of an issue? Is this a problem related to getty? or just =
a=20
missing file or device of some kind? Thanks</DIV>
<DIV><BR></DIV></SPAN></FONT>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Clinton =
Thomas</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6D1F8.91EEED14--
