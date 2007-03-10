Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C9E72DDF01
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 13:32:11 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2A2W402011703
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 19:32:05 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2A2W33l021921
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 20:32:04 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Move 8641 PCI-Express toarch/powerpc/sysdev/fsl_pcie.c.
Date: Sat, 10 Mar 2007 10:32:02 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6B5F@zch01exm23.fsl.freescale.net>
In-Reply-To: <1173460554.23776.232.camel@ld0161-tx32>
References: <1173300525.23776.136.camel@ld0161-tx32>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A11@zch01exm23.fsl.freescale.net>
	<1173460554.23776.232.camel@ld0161-tx32>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Jon Loeliger" <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org, "Haiying-r54964,
	Wang \(Wang Haiying-r54964\)" <Haiying.Wang@freescale.com>, "Yang,
	Xin-Xin \(E-mail\) \(Yang Xin-Xin-r48390\)"
	<Xin-Xin.Yang@freescale.com>, "Wei-r63237,
	Zhang \(Zhang Wei-r63237\)" <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> On Thu, 2007-03-08 at 21:32, Zang Roy-r61911 wrote:
> > > This move sets the stage for the use of generic PCI=20
> Express code in=20
> > > 85xx and 86xx parts from FSL.  Subsequent patches for
> > > 8548 and 8544 will be able to use this shared code.
>=20
>=20
> > How about 8548 with pcie?
> > Roy
>=20
> Roy,
>=20
> This patch that I released was a very simple
> effort to _begin_ the migration of PCI-Ex out
> of 8641 into a generic place so that we can
> get your patches accepted more readily.

Thanks. But I do think it is part of my previous patches :-).=20
My patches mainly contains
(1) Move 86xx pcie support to powerpc/sysdev/fsl_pcie.c and=20
change some CONFIG Option.
(2) Add 8548 pcie support based on fsl_pcie.c. Add PCIE ATMU for 8548.
(3) Remove some reluctant code in fsl_pcie.c.
(4) Add link status check for pcie.
(5) Unify 85xx/86xx pcie mmu register define.
(6) Add device tree for 85xx cds legacy board.

The code for PCIE ATMU and link status check are from Wei Zhang.=20
The patches have been tested for both 85xx/86xx boards and merged to the
85xx git repo. in opensource.freescale.com

>=20
> This first step simply _moved_ the existing file
> out of 8641 and patched up the CONFIG options so
> that 8641 will still work.  Notice that this does
> not yet address the 85xx series boards at all.
> Those patches (yours) will follow shortly.
>=20
> We will need to resolve the problems with the
> transparent bridges issue first, though.  I am
> currently working through some of those issues
> with Kumar.  We can add you to the discussion
> there for sure!
I do not touch the code for common pci/e architecture because more
discussions
might be needed. I had thought to add the  85xx pcie support early. I
received
too many request for its support.
Thanks.
Roy
