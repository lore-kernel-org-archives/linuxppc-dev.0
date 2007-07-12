Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1361CDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 01:25:10 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6CFP5pR001191
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 08:25:05 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6CFP59C001262
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 10:25:05 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] Kernel: Move all technical descriptons of the
	DeviceTree Complier
Date: Thu, 12 Jul 2007 08:25:05 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3030669CE@az33exm25.fsl.freescale.net>
In-Reply-To: <18069.41758.420516.135000@cargo.ozlabs.ibm.com>
References: <1184190359.25384.129.camel@ld0161-tx32>
	<18069.41758.420516.135000@cargo.ozlabs.ibm.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>,
	"Loeliger Jon-LOELIGER" <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Paul Mackerras
> Sent: Wednesday, July 11, 2007 10:42 PM
> To: Loeliger Jon-LOELIGER
> Cc: linuxppc-dev@ozlabs.org; Jon Loeliger
> Subject: Re: [PATCH 1/2] Kernel: Move all technical=20
> descriptons of the DeviceTree Complier
>=20
> Jon Loeliger writes:
>=20
> > and its formats, command lines, descriptions, etc,
> > over to the Device Tree Compiler repositories now.
>=20
> Hrm, section II (DT block format) is a description of a kernel
> interface, and I think it should stay.  After all, there's nothing
> that says that you have to use dtc to generate the device tree blob,
> so there is no reason for the dtc source to be the only place where
> the format is specified.
>=20
> I have no problem with that section being copied over to the dtc
> source.

I think creating copies is going to cause problems as now there will
be two document to be kept in sync.

What's wrong with simply putting a pointer/link in b-w-o.txt to the
DTC source repository and stating the the Linux kernel implements=20
version x.y of the DTC binary blob standard.

After all, many standards may be used by the kernel (e.g. ELF) without
the
standard document itself being kept/mainatined in the kernel source
tree.

The DTB format down the road may be used by hypervisors (e.g. Xen) and
OSes other than Linux, and thus it makes to keep it independent of the
kernel.

Stuart
