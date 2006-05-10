Return-Path: <JDas@alphion.com>
Received: from alphion.com (mail.alphion.com [207.145.47.133])
	by ozlabs.org (Postfix) with ESMTP id DA909679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 04:13:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6745B.CE9DABD4"
Subject: Help: Linux porting to custom target hw
Date: Wed, 10 May 2006 14:01:45 -0400
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B331C626@sbsserver.AlphionCorp.local>
From: "Jayanta Das" <JDas@alphion.com>
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

------_=_NextPart_001_01C6745B.CE9DABD4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello:
=20
Can someone point me in the right direction for some good documentation
on the above topic. Following is what I so far have done and what I need
to do.
=20
1. Set up host environment based on Fedora Core 4
2. Downloaded 'ppc4xx' tool chain, ELDK and kernel
3. Built U-Boot and uImage
4. Flashed U-Boot on the 2nd flash on the Ocotea board (AMCC440GX
PowerPC)
5. Changed the environment variable for NFS mounted root fs and other
MAC and IP addresses as needed
6. TFTP uImage at 400000
7. bootm and kernel boots all right with root fs mounted on the host
=20
I am expecting my hardware based on 440GX end of the month. I told the
HW engineer to follow the peripheral i/f as much possible close to the
ref. design. We are putting 32MB of Flash and 256MB of RAM.
=20
I need some guidance so that I can port U-Boot and the kernel (minimal
changes) so that I can bring up the board initially with root fs NFS
minted and later on the RAMDISK.
=20
Appreciate the help.
=20
Regards.

------_=_NextPart_001_01C6745B.CE9DABD4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana=20
size=3D2>Hello:</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>Can =
someone point=20
me in the right direction for some good documentation on the above =
topic.=20
Following is what I so far have done and what I need to =
do.</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>1. =
Set up host=20
environment based on Fedora Core 4</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>2. =
Downloaded=20
'ppc4xx' tool chain, ELDK and kernel</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>3. =
Built U-Boot=20
and uImage</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>4. =
Flashed U-Boot=20
on the 2nd flash on the Ocotea board (AMCC440GX =
PowerPC)</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>5. =
Changed the=20
environment variable for NFS mounted root fs and other MAC and IP =
addresses as=20
needed</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>6. =
TFTP uImage at=20
400000</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>7. =
bootm and=20
kernel boots all right with root fs mounted on the =
host</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>I am =
expecting my=20
hardware based on 440GX end of the month. I told the HW engineer to =
follow the=20
peripheral i/f as much possible close to the ref. design. We are putting =
32MB of=20
Flash and 256MB of RAM.</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana size=3D2>I =
need some=20
guidance so that I can port U-Boot and the kernel (minimal changes) so =
that I=20
can bring up the board initially with root fs NFS minted and later on =
the=20
RAMDISK.</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana =
size=3D2>Appreciate the=20
help.</FONT></SPAN></DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D036035317-10052006><FONT face=3DVerdana=20
size=3D2>Regards.</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C6745B.CE9DABD4--
