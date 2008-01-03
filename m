Return-Path: <Tony.Li@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 733E5DDE35
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 21:22:25 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m03AMKTX020030
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2008 03:22:20 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m03AMIHj026526
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2008 04:22:19 -0600 (CST)
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
From: Li Li <r64360@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200801031114.05981.arnd@arndb.de>
References: <1199272605.22416.8.camel@Guyver>
	<200801030914.12628.arnd@arndb.de> <1199349066.4437.5.camel@Guyver>
	<200801031114.05981.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 18:08:36 +0800
Message-Id: <1199354916.4437.12.camel@Guyver>
Mime-Version: 1.0
Cc: Phillips Kim <Kim.Phillips@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Tony <Tony.Li@freescale.com>, Wood Scott <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-01-03 at 18:14 +0800, Arnd Bergmann wrote:

> After some more research, I noticed that the distinction between 
> primary and secondary host bridges will go away _anyway_, so 
> I guess we shouldn't worry about it too much.
> 
> On powerpc64, we already don't care, as the
> arch/powerpc/kernel/isa-bridge.c 
> code takes care of legacy I/O areas there, instead of the PCI code. 
> It's only needed on machines with legacy ISA devices (PC keyboard, 
> floppy, ...), and those can be converted to use the isa-bridge code 
> at some point.
> 

This is really a good new :)

- Tony
