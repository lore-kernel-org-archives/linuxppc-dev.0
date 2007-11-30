Return-Path: <Tony.Li@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE4C7DEEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 16:43:38 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lAU5hVwe024863
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 22:43:31 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lAU5hTt0026965
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 23:43:30 -0600 (CST)
Subject: Re: [PATCH] Add MPC837xEMDS PCIE RC mode support
From: Li Li <r64360@freescale.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071130041404.GB26982@lixom.net>
References: <1196394334.29683.5.camel@Guyver>
	<20071130041404.GB26982@lixom.net>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 13:33:53 +0800
Message-Id: <1196400833.31368.2.camel@Guyver>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-11-30 at 12:14 +0800, Olof Johansson wrote:
> Hi,
> 
> On Fri, Nov 30, 2007 at 11:45:34AM +0800, Li Li wrote:
> 
> > +     pci2@e0009000 {
> 
> Why call it pci2@ (and pci3@ below)? They are clearly identifiable
> with 
> their unit addresses anyway.
> 
> > +config PPC_MPC83XX_PCIE 
> > +     bool "MPC837X PCI Express support" 
> > +     depends on PCIEPORTBUS && PPC_MPC837x 
> > +     default n 
> > +     help 
> > +       Enables MPC837x PCI express RC mode
> 
> Why have a separate config option for this?
> 
> For systems where you don't want PCI-e configured, it should be left 
> out of the device tree instead.

It is easy to configure kernel than modify and recompile the dts.
The pcie is default enabled in dts.

> 
> 
> 
> -Olof
> 
- Tony
