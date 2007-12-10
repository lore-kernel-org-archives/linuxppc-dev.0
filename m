Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FE8EDDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 12:33:32 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBA1XTAY009885
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 20:33:29 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBA1XTDN449466
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 20:33:29 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBA1XSxZ024443
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 20:33:29 -0500
Date: Sun, 9 Dec 2007 19:29:53 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 18/25] powerpc: Base support for 440GX Taishan eval board
Message-ID: <20071209192953.7aa1aeb2@zod.rchland.ibm.com>
In-Reply-To: <1197230313.6563.0.camel@pasglop>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080129.737E8DE09F@ozlabs.org>
	<20071206211758.6f086161@zod.rchland.ibm.com>
	<1197183715.6572.8.camel@pasglop>
	<20071209172404.GA26651@lixom.net>
	<1197230313.6563.0.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, Stephen,
	Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 10 Dec 2007 06:58:33 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Sun, 2007-12-09 at 11:24 -0600, Olof Johansson wrote:
> > On Sun, Dec 09, 2007 at 06:01:55PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > Ah yeah, indeed. I'll fix these. (BTW. Could you CC Hugh next time as
> > > he's the author).
> > 
> > I didn't see him Cc:d on the patch submission, and I'm guessing Josh did
> > a reply-all. Seems as if the mailing list manager strips Cc fields of
> > people already subscribed to the list, I've seen it before.
> 
> Yeah, my script for mailing quilt series doesn't do the selective CC
> thingy... Bah, mpe wrote it, I suppose I can either nag him to fix it or
> start learning perl :-)

Or you could just use 'quilt mail' ... 

josh
