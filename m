Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96D50DEA47
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 01:26:59 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m71FQfXH024396
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 11:26:41 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m71FQVvP219322
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 11:26:31 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m71FQUAm003401
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Aug 2008 11:26:31 -0400
Date: Fri, 1 Aug 2008 11:26:28 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: platforms/44x/warp-nand.c bogosity
Message-ID: <20080801112628.35fb0ff2@zod.rchland.ibm.com>
In-Reply-To: <20080801151401.GC24735@cs181140183.pp.htv.fi>
References: <20080801151401.GC24735@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Sean MacLennan <smaclennan@pikatech.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 1 Aug 2008 18:14:01 +0300
Adrian Bunk <bunk@kernel.org> wrote:

> arch/powerpc/platforms/44x/warp-nand.c was added this year and updated 
> quite recently.
> 
> warp-nand.c is empty unless CONFIG_MTD_NAND_NDFC=y.
> 
> MTD_NAND_NDFC depends on !PPC_MERGE.
> 
> !PPC_MERGE can never be true on PPC now that arch/ppc/ got removed.
> 
> So warp-nand.c is dead code, but that does not seem to be intentionally?

I don't believe it is intentional, no.  Sean can you look at this and
see what's up?  I have a couple of fixes to queue up from you already
and if you can get this one done in the next few days I'll included it
as well.

josh
