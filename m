Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 76AB9DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 15:58:58 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l164wvL5020522
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 21:58:57 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l164wtrN024634
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 22:58:56 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Tue, 6 Feb 2007 13:00:12 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D41E2@zch01exm26.fsl.freescale.net>
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

> >> Huh, it would look like:
> >>
> >> #if defined(CONFIG_USB) || defined(CONFIG_USB_GADGET).
> >
> > Are you sure we don't need CONFIG_USB_MODULE and
> > CONFIG_USB_GADGET_MODULE any more?  At least in some early kernel
> > version, they are needed explicitly.
>=20
> I'm not seeing any references to either CONFIG option.

There is no direct reference to the CONFIG_*_MODULE.  But if you
configure a driver to be module, the CONFIG_*_MODULE is defined not
CONFIG_*.  Here we need the init code when USB host or gadget is
selected either as built-in or module.

- Leo
