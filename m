Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 8E0B6DDEBA
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 16:11:29 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l295BPCe024355
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 22:11:25 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l295BNcK005567
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 23:11:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
Date: Fri, 9 Mar 2007 13:11:22 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A32@zch01exm23.fsl.freescale.net>
In-Reply-To: <A74C51F0-4BAE-4B6D-BF16-E911BAC884DC@kernel.crashing.org>
References: <1173300525.23776.136.camel@ld0161-tx32>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A11@zch01exm23.fsl.freescale.net>
	<20303D6D-C19A-4BDB-B540-9994AC538642@kernel.crashing.org>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A16@zch01exm23.fsl.freescale.net>
	<A74C51F0-4BAE-4B6D-BF16-E911BAC884DC@kernel.crashing.org>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> On Mar 8, 2007, at 9:53 PM, Zang Roy-r61911 wrote:
>=20
> >>
> >> On Mar 8, 2007, at 9:32 PM, Zang Roy-r61911 wrote:
> >>
> >>>> This move sets the stage for the use of generic PCI
> >> Express code in
> >>>> 85xx and 86xx parts from FSL.  Subsequent patches for
> >>>> 8548 and 8544 will be able to use this shared code.
> >>>>
> >>>> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> >>>> Acked-by: Andy Fleming <afleming@freescale.com>
> >>>> ---
> >>>>  arch/powerpc/Kconfig                               |    5 +++++
> >>>>  arch/powerpc/platforms/86xx/Makefile               |    2 +-
> >>>>  arch/powerpc/sysdev/Makefile                       |    1 +
> >>>>  .../86xx/mpc86xx_pcie.c =3D> sysdev/fsl_pcie.c}      |    2 --
> >>>>  4 files changed, 7 insertions(+), 3 deletions(-)  rename=20
> >>>> arch/powerpc/{platforms/86xx/mpc86xx_pcie.c =3D> =
sysdev/fsl_pcie.c}
> >>>> (100%)
> >>>>
> >>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig index=20
> >>>> 6dfbd52..f68de20 100644
> >>>> --- a/arch/powerpc/Kconfig
> >>>> +++ b/arch/powerpc/Kconfig
> >>>> @@ -168,6 +168,7 @@ config PPC_86xx
> >>>>  	bool "Freescale 86xx"
> >>>>  	select 6xx
> >>>>  	select FSL_SOC
> >>>> +	select FSL_PCIE
> >>>>  	select PPC_FPU
> >>>>  	select ALTIVEC
> >>>>  	help
> >>>> @@ -1022,6 +1023,10 @@ config SBUS
> >>>>  config FSL_SOC
> >>>>  	bool
> >>>>
> >>>> +config FSL_PCIE
> >>>> +	bool
> >>>> +	depends on PPC_86xx
> >>>> +
> >>> How about 8548 with pcie?
> >>
> >> There isn't any in tree 85xx user of PCIe at this point.
> > No!
> > At lease my original serial patches include the pcie=20
> support for 8548.
> > Roy
>=20
> Which patches?  I'm not seeing any code for 8548. Can you=20
> point at something specific in the tree?

It does not in the current tree.
I will provide the corresponding patches ASAP.
Roy
