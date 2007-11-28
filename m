Return-Path: <rajasekaran.periyasamy@toshiba-tesi.com>
Received: from ironport.toshiba-tesi.com (mail.soc-soft.com [202.56.254.199])
	by ozlabs.org (Postfix) with ESMTP id 83F6CDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 20:35:08 +1100 (EST)
Subject: Getting physical memory information from /proc/iomem
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-dfe3edc3-6f81-4d66-96be-5a652aa70772"
Date: Wed, 28 Nov 2007 12:02:56 +0530
Message-ID: <C5065F118AFB3D478B052FC1E9810D9C47D257@tec-mail.ttec.soc-soft.com>
From: "Rajasekaran Periyasamy" <rajasekaran.periyasamy@toshiba-tesi.com>
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

------=_NextPartTM-000-dfe3edc3-6f81-4d66-96be-5a652aa70772
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83188.8337EACE"

------_=_NextPart_001_01C83188.8337EACE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I have a MPC7447A board running linux 2.6.21. I want to get the physical =
RAM layout from /proc/iomem, but it is not proper as of x86 platform. =
Here is the output of my target's /proc/iomem.

[root@rootfs ~]# cat /proc/iomem
80000000-87ffffff : PCI hose 0 MEM Space 0
  86900000-869fffff : 0000:00:02.2
  86a00000-86afffff : 0000:00:02.2
.
.

  87f00000-87f7ffff : 0000:00:01.0
  87ffffc0-87ffffff : 0000:00:01.0
88000000-8fffffff : PCI hose 1 MEM Space 0
  8d3fe000-8d3fefff : 0001:01:05.2
  8d3ff000-8d3fffff : 0001:01:05.1
.
.

  8e000000-8effffff : 0001:01:04.0
  8f800000-8fffffff : 0001:01:04.0
fbe02000-fbe03fff : ethernet shared base
fbe04000-fbe04c17 : sdma 0 base
  fbe04000-fbe04c17 : sdma_regs
fbe06000-fbe06c17 : sdma 1 base
  fbe06000-fbe06c17 : sdma_regs
fbe08000-fbe08037 : mpsc 0 base
  fbe08000-fbe08037 : mpsc_regs
fbe09000-fbe09037 : mpsc 1 base
  fbe09000-fbe09037 : mpsc_regs
fbe0b200-fbe0b207 : brg 0 base
  fbe0b200-fbe0b207 : brg_regs
fbe0b208-fbe0b20f : brg 1 base
  fbe0b208-fbe0b20f : brg_regs
fbe0b400-fbe0b40b : mpsc routing base
  fbe0b400-fbe0b40b : mpsc_routing_regs
fbe0b800-fbe0b883 : sdma intr base
  fbe0b800-fbe0b883 : sdma_intr_regs
fbe0c000-fbe0c01f : mv64xxx i2c base
  fbe0c000-fbe0c01f : mv64xxx_i2c adapter
ff000000-ffffffff : physmap-flash.0
  ff000000-ffffffff : physmap-flash.0


Can you please anybody tell me how to interpret this to get physical RAM =
addresses. Or is there any patch available to get the details of System =
RAM from /proc/iomem ??

Thanks in advance,
Rajasekaran.P

------_=_NextPart_001_01C83188.8337EACE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7235.2">
<TITLE>Getting physical memory information from /proc/iomem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
I have a MPC7447A board running linux 2.6.21. I want to get the physical =
RAM layout from /proc/iomem, but it is not proper as of x86 platform. =
Here is the output of my target's /proc/iomem.<BR>
<BR>
[root@rootfs ~]# cat /proc/iomem<BR>
80000000-87ffffff : PCI hose 0 MEM Space 0<BR>
&nbsp; 86900000-869fffff : 0000:00:02.2<BR>
&nbsp; 86a00000-86afffff : 0000:00:02.2<BR>
.<BR>
.<BR>
<BR>
&nbsp; 87f00000-87f7ffff : 0000:00:01.0<BR>
&nbsp; 87ffffc0-87ffffff : 0000:00:01.0<BR>
88000000-8fffffff : PCI hose 1 MEM Space 0<BR>
&nbsp; 8d3fe000-8d3fefff : 0001:01:05.2<BR>
&nbsp; 8d3ff000-8d3fffff : 0001:01:05.1<BR>
.<BR>
.<BR>
<BR>
&nbsp; 8e000000-8effffff : 0001:01:04.0<BR>
&nbsp; 8f800000-8fffffff : 0001:01:04.0<BR>
fbe02000-fbe03fff : ethernet shared base<BR>
fbe04000-fbe04c17 : sdma 0 base<BR>
&nbsp; fbe04000-fbe04c17 : sdma_regs<BR>
fbe06000-fbe06c17 : sdma 1 base<BR>
&nbsp; fbe06000-fbe06c17 : sdma_regs<BR>
fbe08000-fbe08037 : mpsc 0 base<BR>
&nbsp; fbe08000-fbe08037 : mpsc_regs<BR>
fbe09000-fbe09037 : mpsc 1 base<BR>
&nbsp; fbe09000-fbe09037 : mpsc_regs<BR>
fbe0b200-fbe0b207 : brg 0 base<BR>
&nbsp; fbe0b200-fbe0b207 : brg_regs<BR>
fbe0b208-fbe0b20f : brg 1 base<BR>
&nbsp; fbe0b208-fbe0b20f : brg_regs<BR>
fbe0b400-fbe0b40b : mpsc routing base<BR>
&nbsp; fbe0b400-fbe0b40b : mpsc_routing_regs<BR>
fbe0b800-fbe0b883 : sdma intr base<BR>
&nbsp; fbe0b800-fbe0b883 : sdma_intr_regs<BR>
fbe0c000-fbe0c01f : mv64xxx i2c base<BR>
&nbsp; fbe0c000-fbe0c01f : mv64xxx_i2c adapter<BR>
ff000000-ffffffff : physmap-flash.0<BR>
&nbsp; ff000000-ffffffff : physmap-flash.0<BR>
<BR>
<BR>
Can you please anybody tell me how to interpret this to get physical RAM =
addresses. Or is there any patch available to get the details of System =
RAM from /proc/iomem ??<BR>
<BR>
Thanks in advance,<BR>
Rajasekaran.P</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C83188.8337EACE--

------=_NextPartTM-000-dfe3edc3-6f81-4d66-96be-5a652aa70772--
