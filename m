Return-Path: <Tony.Li@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EF4EDDE30
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 19:45:03 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m038inIS014145
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2008 01:44:49 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m038ilNu026844
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2008 02:44:48 -0600 (CST)
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
From: Li Li <r64360@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200801030914.12628.arnd@arndb.de>
References: <1199272605.22416.8.camel@Guyver>
	<200801021253.08280.arnd@arndb.de> <1199342440.7375.29.camel@Guyver>
	<200801030914.12628.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 16:31:06 +0800
Message-Id: <1199349066.4437.5.camel@Guyver>
Mime-Version: 1.0
Cc: Wood Scott <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Phillips Kim <Kim.Phillips@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-01-03 at 16:14 +0800, Arnd Bergmann wrote:
> On Thursday 03 January 2008, Li Li wrote: 
> > > * The detection method for the primary bus is somewhat fragile, 
> > > because 
> > > we depend on the order of the nodes in the device tree, which is
> not 
> > > specified to have a meaning. /Maybe/ there could be a property in 
> > > (at most) one of the PCI host bridge nodes saying that this
> specific 
> > > bus 
> > > is the primary one. 
> > > 
> > 
> > Put this primary in code is more save than in dts. 
> > The dts lacks error checking function. If provide error dts such as
> two 
> > pci hosts both has primary property will occur chaos.
> 
> It's easy enough to just panic() if you find more than one primary
> bus, 
> since the information from the device tree is static enough that one 
> will know how to fix this after seeing the error.
> 

It is just a case. what about if do not find primary pci host.
The current code can prevent this potential error and make system
robust.

- Tony
