Return-Path: <sumeshkkn@hotmail.com>
Received: from blu0-omc3-s16.blu0.hotmail.com (blu0-omc3-s16.blu0.hotmail.com
	[65.55.116.91]) by ozlabs.org (Postfix) with ESMTP id EB1EEB6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 26 Sep 2011 04:52:30 +1000 (EST)
Message-ID: <BLU124-W1648A42F7514E880C9B199B4F20@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_ec2bdc40-8459-4d90-8c3b-5df30db25d77_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: <linuxppc-dev@lists.ozlabs.org>, <jwboyer@gmail.com>
Subject: Loading Linux from already running code..
Date: Sun, 25 Sep 2011 18:47:15 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_ec2bdc40-8459-4d90-8c3b-5df30db25d77_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi All=2C
I need some suggestions for booting Linux( >2.6.30 ) with my new project.
Scenario:I've a custom built board with PowerPC 440 + 256 MB RAM. there is =
NO FLASH on this board.There is a hardware logic which will get an initial =
piece of code (through hardware network) into the ram and then execute it. =
This code does mandatory initialization of a proprietary chip and this code=
 MUST execute on power on. any other images (Linux image or ramdisk) can be=
 loaded any specified area in the memory along with this code.
My requirement is to boot Linux at the end of the this initialization.
what is the best way to do it?=20
1. Will it be possible to transfer control to a simpleImage.initrd.myboard.=
elf(or .bin ..?!)  image from already_existing_code?2. Should I use u-boot =
and then load uImage=2C ramdisk and the dts blob? Using u-boot will reduce =
the effort?3. Is there any other way to approach this??


Regards=2CSumesh 		 	   		  =

--_ec2bdc40-8459-4d90-8c3b-5df30db25d77_
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
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
Hi All=2C<div><br></div><div>I need some suggestions for booting Linux( &gt=
=3B2.6.30 ) with my new project.</div><div><br></div><div>Scenario:</div><d=
iv>I've a custom built board with PowerPC 440 + 256 MB RAM. there is NO FLA=
SH on this board.</div><div>There is a hardware logic which will get an ini=
tial piece of code&nbsp=3B(through hardware network)&nbsp=3Binto the ram an=
d then execute it. This code does mandatory initialization of a proprietary=
 chip and this code MUST execute on power on. any other images (Linux image=
 or ramdisk) can be loaded any specified area in the memory along with this=
 code.</div><div><br></div><div>My requirement is to boot Linux at the end =
of the this initialization.</div><div><br></div><div>what is the best way t=
o do it?&nbsp=3B</div><div><br></div><div>1. Will it be possible to transfe=
r control to a simpleImage.initrd.myboard.elf(or .bin ..?!) &nbsp=3Bimage f=
rom already_existing_code?</div><div>2. Should I use u-boot and then load u=
Image=2C ramdisk and the dts blob? Using u-boot will reduce the effort?</di=
v><div>3. Is there any other way to approach&nbsp=3Bthis??</div><div><br></=
div><div><br></div><div><br></div><div>Regards=2C</div><div>Sumesh</div> 		=
 	   		  </div></body>
</html>=

--_ec2bdc40-8459-4d90-8c3b-5df30db25d77_--
