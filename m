Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 206B1DDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 05:48:53 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0FImoix006482
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 13:48:50 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0FImodb113698
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 13:48:50 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0FImnMB005477
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 13:48:50 -0500
Date: Tue, 15 Jan 2008 12:47:29 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] [POWERPC] 4xx: Add 405EXr to cputable
Message-ID: <20080115124729.779f4c0d@zod.rchland.ibm.com>
In-Reply-To: <20080115183809.GD25749@lixom.net>
References: <1200380955-10217-1-git-send-email-sr@denx.de>
	<20080115181924.GA3848@loki.buserror.net>
	<20080115183240.GC25749@lixom.net> <478CFA96.90009@freescale.com>
	<20080115183809.GD25749@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, Stefan,
	Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 Jan 2008 12:38:09 -0600
Olof Johansson <olof@lixom.net> wrote:

> On Tue, Jan 15, 2008 at 12:25:26PM -0600, Scott Wood wrote:
> > Olof Johansson wrote:
> > > On Tue, Jan 15, 2008 at 12:19:24PM -0600, Scott Wood wrote:
> > >> On Tue, Jan 15, 2008 at 08:09:15AM +0100, Stefan Roese wrote:
> > >>> This patch adds the 405EXr to the powerpc cuptable. Basically the 405EXr
> > >>> is a 405EX with only one EMAC and only one PCIe interface.
> > >> Sounds like they have the same core... why do they need separate cputable
> > >> entries?
> > > 
> > > AMCC has always indicated SoC products by new PVRs. This isn't news,
> > > even though it isn't exactly a clean solution. :)
> > 
> > But the old 405EX entry would have matched both chips.  Why add a new 
> > significant bit to pvr_mask?  For the name in /proc/cpuinfo?
> 
> Presumably, yes.
> 
> Again, this is nothing new. Other 405/440 products are doing the same
> thing.

Does anyone have an actual problem with this patch?  I'm inclined to
take it as it doesn't really cause any problems and may eventually be
needed anyway if there is a chip errata or something.

josh
