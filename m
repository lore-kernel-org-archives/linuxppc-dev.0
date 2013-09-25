Return-Path: <B40534@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA23E2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 15:08:33 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0
 define
Date: Wed, 25 Sep 2013 05:08:23 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F154392590108FDF0@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1380014871-22937-1-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717DD00@039-SN2MPN1-011.039d.mgd.msft.net>
 <D3D5E237-6C31-424C-A340-E79F6AF5B0B2@kernel.crashing.org>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717F7DC@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0717F7DC@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Bhushan Bharat-R65777
> Sent: Wednesday, September 25, 2013 11:43 AM
> To: Kumar Gala
> Cc: Wang Dongsheng-B40534; Wood Scott-B07421; linuxppc-
> dev@lists.ozlabs.org
> Subject: RE: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0
> define
>=20
>=20
>=20
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org]
> > Sent: Tuesday, September 24, 2013 9:19 PM
> > To: Bhushan Bharat-R65777
> > Cc: Wang Dongsheng-B40534; Wood Scott-B07421;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and
> > SPRN_PWRMGTCR0 define
> >
> >
> > On Sep 24, 2013, at 6:21 AM, Bhushan Bharat-R65777 wrote:
> >
> > >
> > >
> > >> -----Original Message-----
> > >> From: Linuxppc-dev [mailto:linuxppc-dev-
> > >> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf O=
f
> > >> bounces+Dongsheng
> > >> Wang
> > >> Sent: Tuesday, September 24, 2013 2:58 PM
> > >> To: Wood Scott-B07421
> > >> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> > >> Subject: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and
> > >> SPRN_PWRMGTCR0 define
> > >>
> > >> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >>
> > >> E6500 PVR and SPRN_PWRMGTCR0 will be used in subsequent
> > >> pw20/altivec idle patches.
> > >>
> > >> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >> ---
> > >> *v3:
> > >> Add bit definitions for PWRMGTCR0.
> > >>
> > >> arch/powerpc/include/asm/reg.h       | 2 ++
> > >> arch/powerpc/include/asm/reg_booke.h | 9 +++++++++
> > >> 2 files changed, 11 insertions(+)
> > >>
> > >> diff --git a/arch/powerpc/include/asm/reg.h
> > >> b/arch/powerpc/include/asm/reg.h index 64264bf..d4160ca 100644
> > >> --- a/arch/powerpc/include/asm/reg.h
> > >> +++ b/arch/powerpc/include/asm/reg.h
> > >> @@ -1053,6 +1053,8 @@
> > >> #define PVR_8560	0x80200000
> > >> #define PVR_VER_E500V1	0x8020
> > >> #define PVR_VER_E500V2	0x8021
> > >> +#define PVR_VER_E6500	0x8040
> > >> +
> > >> /*
> > >>  * For the 8xx processors, all of them report the same PVR family
> > >> for
> > >>  * the PowerPC core. The various versions of these processors must
> > >> be diff -- git a/arch/powerpc/include/asm/reg_booke.h
> > >> b/arch/powerpc/include/asm/reg_booke.h
> > >> index ed8f836..4a6457e 100644
> > >> --- a/arch/powerpc/include/asm/reg_booke.h
> > >> +++ b/arch/powerpc/include/asm/reg_booke.h
> > >> @@ -170,6 +170,7 @@
> > >> #define SPRN_L2CSR1	0x3FA	/* L2 Data Cache Control and Status
> Register 1
> > >> */
> > >> #define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
> > >> #define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register
> */
> > >> +#define SPRN_PWRMGTCR0	0x3FB	/* Power management control register
> 0 */
> > >
> > > Is this generic for booke or e6500 specific? I can't see this
> > > register either
> > in ISA and EREF.
> > > Also I can see SPRN_ICCR also with same SPRN, how that is possible?
> >
> > Its possibly because the register maybe in implementation specific
> > region.  I'm guessing ICCR is a 40x specific register.
>=20
> Kumar, this seems to create confusion?=20
I don't think this define will create a confusion, because this is only SPR=
 number
definition and we already have a document(like EREF, ISA, this register def=
ine in
E6500-EREF) to describe these registers. There are no conflicts and other p=
latform
and different platforms for the same register have different purposes, it l=
ooks normal.
Instead we should put together, so as to remind that the SPR will be reuse =
from other platforms.

-dongsheng
