Return-Path: <lzorlov@DIRECTV.com>
Received: from PEGASUS.CORP.FRD.DIRECTV.COM (mail02.directv.com [206.17.88.91])
	by ozlabs.org (Postfix) with ESMTP id 0747C67E36
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 02:44:22 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C59C38.6C2FF384"
Date: Mon, 8 Aug 2005 09:44:19 -0700
Message-ID: <AE35A89453D12D4CA67E62C54F54BFAD0317B09B@castor.directv.com>
From: "Orlov, Leonid" <lzorlov@DIRECTV.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Reducing glibc with mklibs.sh 
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

------_=_NextPart_001_01C59C38.6C2FF384
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,
Does anyone has an example of successful use of either libopt or
mklib.sh in redhat environmet?
I am having hard time to make it work.
I created a myLib library with 3 1 statement function and a main that
use only 2 of the myLib functions.
I am trying to have either tool to detect that only 2 out of 3 functions
are used and reduce myLib correspondingly. So far I have hard time to
have it work.
BTW does mklib dependent on Debian environment. I am using redhat
I am also wondering if Lineo released LIPO for public use.
I called them trying to get a commercial version, they excluded LIPO
from their offerings.
Thanks for your help.
Leonid Orlov

------_=_NextPart_001_01C59C38.6C2FF384
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2523" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D810103416-08082005>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005>Does =
anyone has an=20
example of successful use of either libopt or mklib.sh in redhat=20
environmet?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005>I am =
having hard=20
time to make it work.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005>I =
created a myLib=20
library with 3 1 statement function and a main that use only 2 of the =
myLib=20
functions.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005>I am =
trying to have=20
either tool to detect that only 2 out of 3 functions are used and reduce =
myLib=20
correspondingly. So far I have hard time to have it =
work.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005>BTW =
does mklib=20
dependent on Debian environment. I am using redhat</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005><SPAN=20
class=3D950274116-08082005>I am also wondering if Lineo released LIPO =
for public=20
use.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005><SPAN=20
class=3D950274116-08082005>I called them trying to get a commercial =
version, they=20
excluded LIPO from their offerings.</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005>Thanks =
for your=20
help.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D810103416-08082005>Leonid =

Orlov</SPAN></FONT></DIV></DIV></BODY></HTML>

------_=_NextPart_001_01C59C38.6C2FF384--
