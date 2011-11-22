Return-Path: <Einar.Bjorgvinsson@marel.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 204D4B6F7C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 06:16:58 +1100 (EST)
Received: from mail106-db3 (localhost [127.0.0.1])	by
 mail106-db3-R.bigfish.com (Postfix) with ESMTP id 2609C340347	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 19:16:31 +0000 (UTC)
Received: from DB3EHSMHS019.bigfish.com (unknown [10.3.81.240])	by
 mail106-db3.bigfish.com (Postfix) with ESMTP id 96AE81C0057	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 19:15:29 +0000 (UTC)
From: =?iso-8859-1?Q?Einar_M=E1r_Bj=F6rgvinsson?=
 <Einar.Bjorgvinsson@marel.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Enabling MBX in MPC5121 - OGLES kernel modules
Date: Tue, 22 Nov 2011 19:15:47 +0000
Message-ID: <76E1146DEE728E4E95C1C6D1EEA1DBA96F174768@GRBSR0004.marel.net>
Content-Type: multipart/alternative;
 boundary="_000_76E1146DEE728E4E95C1C6D1EEA1DBA96F174768GRBSR0004mareln_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_76E1146DEE728E4E95C1C6D1EEA1DBA96F174768GRBSR0004mareln_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi

I've been working on enabling the PowerVR GPU core in MPC5121 chip. I've be=
en following the documentation from here:

http://www.datasheetarchive.com/indexdl/Datasheet-076/DSAE0026055.pdf

This documentation was released in a bundle with MBX libraries and MBX kern=
el patches. Also have I downloaded the OGLES SDK from Imgtech where I've su=
ccessfully built some demos for MPC5121.

The last piece of the puzzle is to have the right kernel modules. There are=
 some kernel modules provided in the documentation bundle but they are buil=
d against older kernel version (2.6.24) but I'm am using kernel version 2.6=
.33 with RT 29.

What I'm hoping is that somebody have the source code for the following ker=
nel modules:

- pvr.ko
- clcdc.ko
- swcamera.ko
- dgbdrv.ko

Hope somebody out there can assist

Regards
Einar M. Bjorgvinsson
Embedded Software Engineer
Marel ehf
Iceland


--_000_76E1146DEE728E4E95C1C6D1EEA1DBA96F174768GRBSR0004mareln_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Hi<br>
<br>
I've been working on enabling the PowerVR GPU core in MPC5121 chip. I've be=
en following the documentation from here:
<br>
<br>
<font size=3D"2"><span style=3D"font-size: 10pt;"><a href=3D"http://www.dat=
asheetarchive.com/indexdl/Datasheet-076/DSAE0026055.pdf" target=3D"_blank">=
http://www.datasheetarchive.com/indexdl/Datasheet-076/DSAE0026055.pdf</a><b=
r>
<br>
This documentation was released in a bundle with MBX libraries and MBX kern=
el patches. Also have I downloaded the OGLES SDK from Imgtech where I've su=
ccessfully built some demos for MPC5121.
<br>
<br>
The last piece of the puzzle is to have the right kernel modules. There are=
 some kernel modules provided in the documentation bundle but they are buil=
d against older kernel version (2.6.24) but I'm am using kernel version 2.6=
.33 with RT 29.
<br>
<br>
What I'm hoping is that somebody have the source code for the following ker=
nel modules:<br>
<br>
- pvr.ko<br>
- clcdc.ko<br>
- swcamera.ko<br>
- dgbdrv.ko<br>
<br>
Hope somebody out there can assist<br>
<br>
Regards<br>
Einar M. Bjorgvinsson <br>
Embedded Software Engineer<br>
Marel ehf<br>
Iceland<br>
<br>
</span></font></div>
</body>
</html>

--_000_76E1146DEE728E4E95C1C6D1EEA1DBA96F174768GRBSR0004mareln_--
