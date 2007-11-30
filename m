Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 18263DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 08:45:43 +1100 (EST)
Subject: Re: [PATCH 18/24] powerpc: Base support for 440GX Taishan eval board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071130153242.6ea7e5ae@zod.rchland.ibm.com>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130061203.B6239DDED7@ozlabs.org>
	<20071130140825.67721825@zod.rchland.ibm.com>
	<1196456229.13230.102.camel@pasglop>
	<20071130153242.6ea7e5ae@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 08:44:41 +1100
Message-Id: <1196459081.13230.106.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-30 at 15:32 -0600, Josh Boyer wrote:
> On Sat, 01 Dec 2007 07:57:09 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > On Fri, 2007-11-30 at 14:08 -0600, Josh Boyer wrote:
> > > On Fri, 30 Nov 2007 17:11:01 +1100
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > 
> > > > From: Hugh Blemings <hugh@blemings.org>
> > > > 
> > > > 
> > > > Signed-off-by: Hugh Blemings <hugh@blemings.org>
> > > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > ---
> > > > 
> > > > This needs a bit of cleanup still, probably not to be merged as-is
> > > > just yet (like using mtdcri/mfdcri for CPR access).
> > > > 
> > > >  arch/powerpc/Kconfig.debug           |    6 
> > > >  arch/powerpc/boot/44x.h              |    1 
> > > >  arch/powerpc/boot/Makefile           |    7 
> > > 
> > > Small conflict in the Makefile keeps this from applying cleanly.
> > 
> > Can you tell me more ? doesn't conflict here.
> 
> You have cuImage.bamboo with a comment in front of it.

Oh... yeah, ok, my bad, I see where that comes from. I'll fix it up.

Cheers,
Ben.
