Return-Path: <dorin1234@outlook.com>
Received: from bay0-omc3-s11.bay0.hotmail.com (bay0-omc3-s11.bay0.hotmail.com
 [65.54.190.149]) by ozlabs.org (Postfix) with ESMTP id 1DB332C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 12:48:52 +1000 (EST)
Message-ID: <BAY176-W43D0B5AD1BD2454470D8AFA6210@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_7894ba37-3468-41a5-b817-c6f81125867c_"
From: Dorin D <dorin1234@outlook.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Linux 2.6.32 PowerPC MTD partition mounted at boot
Date: Wed, 18 Sep 2013 22:43:42 -0400
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_7894ba37-3468-41a5-b817-c6f81125867c_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am working on bringing up two Linux systems=2C both based on Freescale Po=
werPC devices=2C one is a MPC8349=2C the other a P1020. I was able to build=
=2C install and boot the kernel on both cards. The kernel is 2.6.32 and the=
  toolchains  are coming from the LTIBs packages from Freescale. Both cards=
 have a 32 MByte NOR flash memory (AMD) boot flash. I have Uboot=2C kernel=
=2C RAM disk image and DTB in the boot flash and I want to use the spare sp=
ace (about 20 MBytes) as flash file system. I have the following problem : =
the P1020 board boots fine using the RAM disk with the flash in the device =
tree =2C shows the flash device partitions (JFFS2) and DOESN"T try to mount=
 a flash partition as root. The MPC8349 boots fine from the RAM disk but=2C=
 after identifying the flash partitions=2C the kernel panics because is loo=
king for a flash partition to mount as root partition and none of them is u=
sable (not formatted). If I remove the flash from the device tree=2C the ca=
rd boots fine using the RAM disk.
I am not too familiar with Linux boot scripts and I didn't figure out where=
 I can disable this tentative of mounting the MTD partition. I want the boa=
rds to boot and mount the RAM disk=2C as the P1020 board does. The flash pa=
rtition will be initialized and mounted at a later time=2C but not as root =
partition.
TIADorin
 		 	   		  =

--_7894ba37-3468-41a5-b817-c6f81125867c_
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
<body class=3D'hmmessage'><div dir=3D'ltr'><p style=3D"margin-bottom: 1em=
=3B border: 0px=3B font-size: 14px=3B vertical-align: baseline=3B clear: bo=
th=3B word-wrap: break-word=3B font-family: Arial=2C 'Liberation Sans'=2C '=
DejaVu Sans'=2C sans-serif=3B line-height: 18px=3B">I am working on bringin=
g up two Linux systems=2C both based on Freescale PowerPC devices=2C one is=
 a MPC8349=2C the other a P1020. I was able to build=2C install and boot th=
e kernel on both cards. The kernel is 2.6.32 and the &nbsp=3Btoolchains &nb=
sp=3Bare coming from the LTIBs packages from Freescale.&nbsp=3B</p><p style=
=3D"margin-bottom: 1em=3B border: 0px=3B font-size: 14px=3B vertical-align:=
 baseline=3B clear: both=3B word-wrap: break-word=3B font-family: Arial=2C =
'Liberation Sans'=2C 'DejaVu Sans'=2C sans-serif=3B line-height: 18px=3B">B=
oth cards have a 32 MByte NOR flash memory (AMD) boot flash. I have Uboot=
=2C kernel=2C RAM disk image and DTB in the boot flash and I want to use th=
e spare space (about 20 MBytes) as flash file system.&nbsp=3B</p><p style=
=3D"margin-bottom: 1em=3B border: 0px=3B font-size: 14px=3B vertical-align:=
 baseline=3B clear: both=3B word-wrap: break-word=3B font-family: Arial=2C =
'Liberation Sans'=2C 'DejaVu Sans'=2C sans-serif=3B line-height: 18px=3B">I=
 have the following problem : the P1020 board boots fine using the RAM disk=
 with the flash in the device tree =2C shows the flash device partitions (J=
FFS2) and DOESN"T try to mount a flash partition as root. The MPC8349 boots=
 fine from the RAM disk but=2C after identifying the flash partitions=2C th=
e kernel panics because is looking for a flash partition to mount as root p=
artition and none of them is usable (not formatted). If I remove the flash =
from the device tree=2C the card boots fine using the RAM disk.</p><p style=
=3D"margin-bottom: 1em=3B border: 0px=3B font-size: 14px=3B vertical-align:=
 baseline=3B clear: both=3B word-wrap: break-word=3B font-family: Arial=2C =
'Liberation Sans'=2C 'DejaVu Sans'=2C sans-serif=3B line-height: 18px=3B"><=
br></p><p style=3D"margin-bottom: 1em=3B border: 0px=3B font-size: 14px=3B =
vertical-align: baseline=3B clear: both=3B word-wrap: break-word=3B font-fa=
mily: Arial=2C 'Liberation Sans'=2C 'DejaVu Sans'=2C sans-serif=3B line-hei=
ght: 18px=3B">I am not too familiar with Linux boot scripts and I didn't fi=
gure out where I can disable this tentative of mounting the MTD partition. =
I want the boards to boot and mount the RAM disk=2C as the P1020 board does=
. The flash partition will be initialized and mounted at a later time=2C bu=
t not as root partition.</p><p style=3D"margin-bottom: 1em=3B border: 0px=
=3B font-size: 14px=3B vertical-align: baseline=3B clear: both=3B word-wrap=
: break-word=3B font-family: Arial=2C 'Liberation Sans'=2C 'DejaVu Sans'=2C=
 sans-serif=3B line-height: 18px=3B"><br></p><p style=3D"margin-bottom: 1em=
=3B border: 0px=3B font-size: 14px=3B vertical-align: baseline=3B clear: bo=
th=3B word-wrap: break-word=3B font-family: Arial=2C 'Liberation Sans'=2C '=
DejaVu Sans'=2C sans-serif=3B line-height: 18px=3B">TIA</p><p style=3D"marg=
in-bottom: 1em=3B border: 0px=3B font-size: 14px=3B vertical-align: baselin=
e=3B clear: both=3B word-wrap: break-word=3B font-family: Arial=2C 'Liberat=
ion Sans'=2C 'DejaVu Sans'=2C sans-serif=3B line-height: 18px=3B">Dorin</p>=
<p style=3D"margin-bottom: 1em=3B border: 0px=3B font-size: 14px=3B vertica=
l-align: baseline=3B clear: both=3B word-wrap: break-word=3B font-family: A=
rial=2C 'Liberation Sans'=2C 'DejaVu Sans'=2C sans-serif=3B line-height: 18=
px=3B"><br></p> 		 	   		  </div></body>
</html>=

--_7894ba37-3468-41a5-b817-c6f81125867c_--
