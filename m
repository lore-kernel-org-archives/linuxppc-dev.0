Return-Path: <cedric.maussire@cassidian.com>
Received: from mail-dotnet4.eads.net (mail-dotnet4.eads.net [193.56.40.77])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "IronPort Appliance Demo Certificate",
 Issuer "IronPort Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 89C68B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 19:17:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----_=_NextPart_001_01CD42FB.ED917EA0"
Subject: RE: Cannot boot an kernel version other than 2.6.35 on P2020RDB-PCA
Date: Tue, 5 Jun 2012 11:16:45 +0200
Message-ID: <2A5271086BF5EA4A891F3804135DEA820795A3BA@TLSEVS01.ts.eads.lcl>
References: <2A5271086BF5EA4A891F3804135DEA820795A3B5@TLSEVS01.ts.eads.lcl>
 <D07C73A334FF604B95B3CBD2A545D07B079A63F1@039-SN2MPN1-012.039d.mgd.msft.net>
From: "MAUSSIRE Cedric" <cedric.maussire@cassidian.com>
To: "Tang Yuantian-B29983" <B29983@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.


------_=_NextPart_001_01CD42FB.ED917EA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Yuantian

Thanks for the tip, it's working fine on kernel 3.4.

And yes the board works on linux kernel 2.6.35. I have downloaded the =
mainline code on kernel.org and use the "qoriq_sdk_defconfig" provided =
with system builder of Freescale, but it is only working with this =
defconfig file and not with the default one "mpc85xx_defconfig"....

Best regards,

Cedric


-----Original Message-----
From: Tang Yuantian-B29983 [mailto:B29983@freescale.com]
Sent: Tue 6/5/2012 4:28 AM
To: MAUSSIRE Cedric; linuxppc-dev@lists.ozlabs.org
Subject: RE: Cannot boot an kernel version other than 2.6.35 on =
P2020RDB-PCA
=20
Hi  Cedric MAUSSIRE,

P2020RDB-PCA Board gets supported since kernel 3.3 in mainline code.
Are you sure the board works on kernel 2.6.35?

Regards,
Yuantian

From: linuxppc-dev-bounces+b29983=3Dfreescale.com@lists.ozlabs.org =
[mailto:linuxppc-dev-bounces+b29983=3Dfreescale.com@lists.ozlabs.org] On =
Behalf Of MAUSSIRE Cedric
Sent: 2012?6?4? 23:06
To: linuxppc-dev@lists.ozlabs.org
Subject: Cannot boot an kernel version other than 2.6.35 on P2020RDB-PCA


Hello all,

I am currently working on the Freescale P2020RDB-PCA Board, which has =
been delivred with the linux-2.6.35 kernel. I succeed in re-generating =
my own uImage in 2.6.35 thanks to ELDK, but when I want to move on to a =
newer or older version of linux, the system does not respond any longer =
just after the boot whith the nfsboot command, the logs are :

## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-2.6.39
   Created:      2012-05-29   8:24:54 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    3514882 Bytes =3D 3.4 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 00c00000
   Booting using the fdt blob at 0xc00000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 00ffa000, end 00fffd4a ... OK

NB : nfsboot=3Dsetenv bootargs root=3D/dev/nfs rw =
nfsroot=3D192.168.1.1:$rootpath =
ip=3D192.168.1.2:192.168.1.1:192.168.1.1:255.255.255.0:P2020RDB-PC:eth0:o=
ff console=3DttyS0,115200

I have unsuccessfully tried to rebuild the device tree blob and use the =
default kernel configuration "mpc85xx_defconfig" that comes with the =
mainline code.

My systems seems to be linux-2.6.35 dependent, I do not known how it can =
be possible, because I can use the kernel.org source of the 2.6.35 whith =
no problems but when I use the 3.0, for example, with the same =
configuration but it does not work.


Best regards,


Cedric MAUSSIRE


------_=_NextPart_001_01CD42FB.ED917EA0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: Cannot boot an kernel version other than 2.6.35 on =
P2020RDB-PCA</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Yuantian<BR>
<BR>
Thanks for the tip, it's working fine on kernel 3.4.<BR>
<BR>
And yes the board works on linux kernel 2.6.35. I have downloaded the =
mainline code on kernel.org and use the &quot;qoriq_sdk_defconfig&quot; =
provided with system builder of Freescale, but it is only working with =
this defconfig file and not with the default one =
&quot;mpc85xx_defconfig&quot;....<BR>
<BR>
Best regards,<BR>
<BR>
Cedric<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Tang Yuantian-B29983 [<A =
HREF=3D"mailto:B29983@freescale.com">mailto:B29983@freescale.com</A>]<BR>=

Sent: Tue 6/5/2012 4:28 AM<BR>
To: MAUSSIRE Cedric; linuxppc-dev@lists.ozlabs.org<BR>
Subject: RE: Cannot boot an kernel version other than 2.6.35 on =
P2020RDB-PCA<BR>
<BR>
Hi&nbsp; Cedric MAUSSIRE,<BR>
<BR>
P2020RDB-PCA Board gets supported since kernel 3.3 in mainline code.<BR>
Are you sure the board works on kernel 2.6.35?<BR>
<BR>
Regards,<BR>
Yuantian<BR>
<BR>
From: linuxppc-dev-bounces+b29983=3Dfreescale.com@lists.ozlabs.org [<A =
HREF=3D"mailto:linuxppc-dev-bounces+b29983=3Dfreescale.com@lists.ozlabs.o=
rg">mailto:linuxppc-dev-bounces+b29983=3Dfreescale.com@lists.ozlabs.org</=
A>] On Behalf Of MAUSSIRE Cedric<BR>
Sent: 2012?6?4? 23:06<BR>
To: linuxppc-dev@lists.ozlabs.org<BR>
Subject: Cannot boot an kernel version other than 2.6.35 on =
P2020RDB-PCA<BR>
<BR>
<BR>
Hello all,<BR>
<BR>
I am currently working on the Freescale P2020RDB-PCA Board, which has =
been delivred with the linux-2.6.35 kernel. I succeed in re-generating =
my own uImage in 2.6.35 thanks to ELDK, but when I want to move on to a =
newer or older version of linux, the system does not respond any longer =
just after the boot whith the nfsboot command, the logs are :<BR>
<BR>
## Booting kernel from Legacy Image at 01000000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.39<BR>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2012-05-29&nbsp;&nbsp; 8:24:54 UTC<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 3514882 Bytes =3D 3.4 MiB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
## Flattened Device Tree blob at 00c00000<BR>
&nbsp;&nbsp; Booting using the fdt blob at 0xc00000<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
&nbsp;&nbsp; Loading Device Tree to 00ffa000, end 00fffd4a ... OK<BR>
<BR>
NB : nfsboot=3Dsetenv bootargs root=3D/dev/nfs rw =
nfsroot=3D192.168.1.1:$rootpath =
ip=3D192.168.1.2:192.168.1.1:192.168.1.1:255.255.255.0:P2020RDB-PC:eth0:o=
ff console=3DttyS0,115200<BR>
<BR>
I have unsuccessfully tried to rebuild the device tree blob and use the =
default kernel configuration &quot;mpc85xx_defconfig&quot; that comes =
with the mainline code.<BR>
<BR>
My systems seems to be linux-2.6.35 dependent, I do not known how it can =
be possible, because I can use the kernel.org source of the 2.6.35 whith =
no problems but when I use the 3.0, for example, with the same =
configuration but it does not work.<BR>
<BR>
<BR>
Best regards,<BR>
<BR>
<BR>
Cedric MAUSSIRE<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CD42FB.ED917EA0--
