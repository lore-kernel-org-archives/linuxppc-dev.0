Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC3S12.hotmail.com (dub004-omc3s12.hotmail.com
 [157.55.2.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77A451A0C4B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 01:37:03 +1100 (AEDT)
Message-ID: <DUB117-W108D94F2E48828981DD3655C84B0@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_5c431922-ed01-4d1e-9159-d6df54e292b7_"
From: luigi burdo <intermediadc@hotmail.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PowerMac G5 Quad Issue reporting
Date: Tue, 20 Jan 2015 15:36:58 +0100
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_5c431922-ed01-4d1e-9159-d6df54e292b7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all LinuxPPc Developer=2C
need to report a issue that im facing from kernel 3.16 and up.

The fans of powermac g5 quad start boosting like a turbo jet after the syst=
em is=20
been loaded and up.=20
Usually this become after about 30-60 seconds when the system is loaded.
This issue start with Xorg loaded or only in teminal system (gdm3 not loade=
d)
This issue come with system load with minimum cpu usage  5%  and less too.
During the closing of the system (reboot) the fans goes in right silents mo=
de.


I had been tested and compiled the kernel with all the modules of fan contr=
ols for Apple G5=20
without a positive result.
Kernel tested 3.16.ctk2 (debian wheezy 7.8)=2C 3.18.3 and  3.19.rc5
Im using Debian Wheezy 7.6 (up 7.8) PPC on Quad G5 (970mp) Nvidia 7800gtx a=
nd RadeonHD 6570

Dont face this issue with old kernels version 3.10.65 and pre
(didnt test the 3.12 and 3.14)=20

Need to report to Michel D. from amd.com . The RadeonHD 6570 now is working=
 on PowerMac G5 too
look like the Xorg bigendian  issue related Evergreen / Northern  is been f=
ixed =3B-)


Thanks alot for your jobs guys
Hope soon i will able to help in X5000 hardware too=20
PPC Rulez ... and sorry for my "perfect english"
Luigi Burdo 		 	   		  =

--_5c431922-ed01-4d1e-9159-d6df54e292b7_
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
<body class=3D'hmmessage'><div dir=3D'ltr'>Hello all LinuxPPc Developer=2C<=
br>need to report a issue that im facing from kernel 3.16 and up.<br><br>Th=
e fans of powermac g5 quad start boosting like a turbo jet after the system=
 is <br>been loaded and up. <br>Usually this become after about 30-60 secon=
ds when the system is loaded.<br>This issue start with Xorg loaded or only =
in teminal system (gdm3 not loaded)<br>This issue come with system load wit=
h minimum cpu usage&nbsp=3B 5%&nbsp=3B and less too.<br>During the closing =
of the system (reboot) the fans goes in right silents mode.<br><br><br>I ha=
d been tested and compiled the kernel with all the modules of fan controls =
for Apple G5 <br>without a positive result.<br>Kernel tested 3.16.ctk2 (deb=
ian wheezy 7.8)=2C 3.18.3 and&nbsp=3B 3.19.rc5<br>Im using Debian Wheezy 7.=
6 (up 7.8) PPC on Quad G5 (970mp) Nvidia 7800gtx and RadeonHD 6570<br><br>D=
ont face this issue with old kernels version 3.10.65 and pre<br>(didnt test=
 the 3.12 and 3.14) <br><br>Need to report to Michel D. from amd.com . The =
RadeonHD 6570 now is working on PowerMac G5 too<br>look like the Xorg bigen=
dian&nbsp=3B issue related Evergreen / Northern&nbsp=3B is been fixed =3B-)=
<br><br><br>Thanks alot for your jobs guys<br>Hope soon i will able to help=
 in X5000 hardware too <br>PPC Rulez ... and sorry for my "perfect english"=
<br>Luigi Burdo 		 	   		  </div></body>
</html>=

--_5c431922-ed01-4d1e-9159-d6df54e292b7_--
