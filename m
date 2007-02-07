Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 85144DDE40
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 13:26:06 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l172Q52l026222
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 19:26:05 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l172Q3BN023191
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 20:26:04 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 10:27:20 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D4289@zch01exm26.fsl.freescale.net>
In-Reply-To: <E802A223-6809-453B-B451-4A3A0AC87F66@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, February 07, 2007 12:31 AM
> To: Kumar Gala
> Cc: Li Yang-r58472; linuxppc-dev@ozlabs.org; Paul
> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>=20
>=20
> On Feb 6, 2007, at 8:37 AM, Kumar Gala wrote:
>=20
> >
> > On Feb 6, 2007, at 3:05 AM, Li Yang wrote:
> >
> >> Add board specific initialization code for USB
> >> to work in both MPH and DR mode for MPC8349EMDS
> >> PB board.
> >>
> >> Signed-off-by: Li Yang <leoli@freescale.com>
> >> ---
> >>
> >> arch/powerpc/platforms/83xx/Kconfig       |    4 ++
> >> arch/powerpc/platforms/83xx/mpc834x_sys.c |   79
+++++++++++++++++++
> >> ++++++++++
> >> arch/powerpc/platforms/83xx/mpc834x_sys.h |    2 +
> >> arch/powerpc/platforms/83xx/mpc83xx.h     |   18 +++++++
> >> 4 files changed, 103 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
> >> platforms/83xx/Kconfig
> >> index edcd5b8..5371645 100644
> >> --- a/arch/powerpc/platforms/83xx/Kconfig
> >> +++ b/arch/powerpc/platforms/83xx/Kconfig
> >> @@ -59,4 +59,8 @@ config PPC_MPC836x
> >> 	select PPC_INDIRECT_PCI
> >> 	default y if MPC8360E_PB
> >> +config 834x_USB_SUPPORT
> >> +	bool
> >> +	default y if MPC834x_SYS && (USB || USB_GADGET)
> >> +
> >
> > I'm still not convinced we need a new config option for this.
>=20
> Ok, I see what this now accomplishes, but why don't we just build the
> support in always, lets just remove the config option altogether?

To save some space and time for embedded product which doesn't really
need usb?

- Leo
