Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC3S7.hotmail.com (dub004-omc3s7.hotmail.com
 [157.55.2.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qs2GD5LmWzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 03:11:32 +1000 (AEST)
Message-ID: <DUB117-W972E5DAF4FC0B745E9B1F7C86F0@phx.gbl>
Content-Type: multipart/mixed;
 boundary="_858d2df0-6d05-4d52-960f-f0b282b1d6e2_"
From: luigi burdo <intermediadc@hotmail.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: radeonhd and xorg issues on powerpc p5020 and G5
Date: Fri, 22 Apr 2016 19:06:07 +0200
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_858d2df0-6d05-4d52-960f-f0b282b1d6e2_
Content-Type: multipart/alternative;
	boundary="_9cf5b385-899c-4fdc-b85f-8f0704b3e0f4_"

--_9cf5b385-899c-4fdc-b85f-8f0704b3e0f4_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello devs=2C
during  my testing on ppc hardware  im facing issue with xorgs and radeon h=
d
on varisys/Aeon Cyrus+ P5020 machine and on Quad G5 hardware too.

On Quad G5 with 2 video boards
if i set radeon.modeset=3D1  nouveau.modeset=3D1 Xorg -configure dont found=
 at all the video boards=20
if i set radeon.modeset=3D0  nouveau.modeset=3D1 Xorg -configure dont found=
 the nouveau board=20
if i set radeon.modeset=3D1  nouveau.modeset=3D0 Xorg -configure dont found=
 the radeon board=20
if i set radeon.modeset=3D0  nouveau.modeset=3D0 no video working ... no tt=
y too =3B-)

On P5020
last of my test is this machine with a  radeon hd 7770 core edition
if radeon drv is running the system run in softpipe mode and i face many dr=
m errors and fence issue.
i atteched the dmesg files.


If something else is needed ask without any problems

Thanks=20
Luigi
 		 	   		  =

--_9cf5b385-899c-4fdc-b85f-8f0704b3e0f4_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Hello devs=2C<br>during&nbsp=3B =
my testing on ppc hardware&nbsp=3B im facing issue with xorgs and radeon hd=
<br>on varisys/Aeon Cyrus+ P5020 machine and on Quad G5 hardware too.<br><b=
r>On Quad G5 with 2 video boards<br>if i set radeon.modeset=3D1&nbsp=3B nou=
veau.modeset=3D1 Xorg -configure dont found at all the video boards <br>if =
i set radeon.modeset=3D0&nbsp=3B nouveau.modeset=3D1 Xorg -configure dont f=
ound the nouveau board <br>if i set radeon.modeset=3D1&nbsp=3B nouveau.mode=
set=3D0 Xorg -configure dont found the radeon board <br>if i set radeon.mod=
eset=3D0&nbsp=3B nouveau.modeset=3D0 no video working ... no tty too =3B-)<=
br><br>On P5020<br>last of my test is this machine with a&nbsp=3B radeon hd=
 7770 core edition<br>if radeon drv is running the system run in softpipe m=
ode and i face many drm errors and fence issue.<br>i atteched the dmesg fil=
es.<br><br><br>If something else is needed ask without any problems<br><br>=
Thanks <br>Luigi<br> 		 	   		  </div></body>
</html>=

--_9cf5b385-899c-4fdc-b85f-8f0704b3e0f4_--

--_858d2df0-6d05-4d52-960f-f0b282b1d6e2_
Content-Type: application/x-gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.tar.gz"

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
y1jGMpaxjGUsYxnLWMYSvfwfoUIQlQCgAAA=

--_858d2df0-6d05-4d52-960f-f0b282b1d6e2_--
