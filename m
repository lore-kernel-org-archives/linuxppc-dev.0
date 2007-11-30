Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3FC7DDE03
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 08:34:34 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAULYUNw032307
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 16:34:30 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAULYF6g099854
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 14:34:15 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAULYEVX012384
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 14:34:14 -0700
Date: Fri, 30 Nov 2007 15:32:42 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 18/24] powerpc: Base support for 440GX Taishan eval board
Message-ID: <20071130153242.6ea7e5ae@zod.rchland.ibm.com>
In-Reply-To: <1196456229.13230.102.camel@pasglop>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130061203.B6239DDED7@ozlabs.org>
	<20071130140825.67721825@zod.rchland.ibm.com>
	<1196456229.13230.102.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 01 Dec 2007 07:57:09 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2007-11-30 at 14:08 -0600, Josh Boyer wrote:
> > On Fri, 30 Nov 2007 17:11:01 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > From: Hugh Blemings <hugh@blemings.org>
> > > 
> > > 
> > > Signed-off-by: Hugh Blemings <hugh@blemings.org>
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > ---
> > > 
> > > This needs a bit of cleanup still, probably not to be merged as-is
> > > just yet (like using mtdcri/mfdcri for CPR access).
> > > 
> > >  arch/powerpc/Kconfig.debug           |    6 
> > >  arch/powerpc/boot/44x.h              |    1 
> > >  arch/powerpc/boot/Makefile           |    7 
> > 
> > Small conflict in the Makefile keeps this from applying cleanly.
> 
> Can you tell me more ? doesn't conflict here.

You have cuImage.bamboo with a comment in front of it.

josh
