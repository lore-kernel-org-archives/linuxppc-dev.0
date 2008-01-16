Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64937DDE9B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 10:36:05 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0GNa1h4018893
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 18:36:01 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0GNa1dg155890
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 18:36:01 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0GNa0ft028455
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 18:36:01 -0500
Date: Wed, 16 Jan 2008 17:34:21 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] MTD for Taco
Message-ID: <20080116173421.4c886514@zod.rchland.ibm.com>
In-Reply-To: <478E7643.5040804@pikatech.com>
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
	<478AEB39.70106@pikatech.com> <478E7643.5040804@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Jan 2008 16:25:23 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Sean MacLennan wrote:
> > How about adding a config option that lets you specify 8 bit access? 
> > Something like CONFIG_NDFC_8BIT_ACCESS. We could default it to no and 
> > put a little blurb that says something like:
> >
> > On some platforms the 32bit read/writes cause a machine access 
> > exception. If you get a machine access exception while reading the NAND 
> > bad block table, try turning on 8 bit access.
> >   
> I know it would be better if 32 bit access just worked, but nobody 
> actively objected to this idea, so here is a patch ;)

I'm objecting, but not on the bit access reasons :).

1) Needs to go to the linux-mtd@lists.infradead.org list with the
maintainer CC'd (Thomas Gleixner)

2) I don't want this driver enabled in mainline for boards in
arch/powerpc until it fully understands how to parse device trees.

You could separate out the 8-bit access option and send that to
linux-mtd though

josh
