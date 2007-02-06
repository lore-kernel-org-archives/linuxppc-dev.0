Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 9E9EDDDDE5
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 15:51:36 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l164pYAX018963
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 21:51:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l164pTKX015173
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 22:51:30 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Tue, 6 Feb 2007 12:52:46 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D41E0@zch01exm26.fsl.freescale.net>
In-Reply-To: <C51879CA-3989-4E6C-9C5A-9839B3E93EB6@kernel.crashing.org>
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

> >>>>> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/
> >>>>> platforms/83xx/Kconfig
> >>>>> index edcd5b8..5371645 100644
> >>>>> --- a/arch/powerpc/platforms/83xx/Kconfig
> >>>>> +++ b/arch/powerpc/platforms/83xx/Kconfig
> >>>>> @@ -59,4 +59,8 @@ config PPC_MPC836x
> >>>>> 	select PPC_INDIRECT_PCI
> >>>>> 	default y if MPC8360E_PB
> >>>>> +config 834x_USB_SUPPORT
> >>>>> +	bool
> >>>>> +	default y if MPC834x_SYS && (USB || USB_GADGET)
> >>>>> +
> >>>>
> >>>> Do we really need to introduce a new config option?
> >>>
> >>> It will be neater to make use of the Kconfig feature than judging
> > all
> >>> the macros and module variations.  It will be a very long #if
> > defined
> >>> the other way.
> >>
> >> Huh, it would look like:
> >>
> >> #if defined(CONFIG_USB) || defined(CONFIG_USB_GADGET).
> >
> > Are you sure we don't need CONFIG_USB_MODULE and
> > CONFIG_USB_GADGET_MODULE any more?  At least in some early kernel
> > version, they are needed explicitly.
>=20
> I'm not seeing any references to either CONFIG option.
>=20
> Also, I'm not seeing any code to support OTG for ehci/83xx... (in the
> kernel tree).  Are there patches for this?

The complete OTG protocol support is not submitted yet, but the OTG mode
support for ehci-fsl is submitted to linux-usb.

- Leo
