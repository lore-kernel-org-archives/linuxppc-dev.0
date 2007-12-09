Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4DD71DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 06:59:57 +1100 (EST)
Subject: Re: [PATCH 18/25] powerpc: Base support for 440GX Taishan eval board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071209172404.GA26651@lixom.net>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080129.737E8DE09F@ozlabs.org>
	<20071206211758.6f086161@zod.rchland.ibm.com>
	<1197183715.6572.8.camel@pasglop>  <20071209172404.GA26651@lixom.net>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 06:58:33 +1100
Message-Id: <1197230313.6563.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-12-09 at 11:24 -0600, Olof Johansson wrote:
> On Sun, Dec 09, 2007 at 06:01:55PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Ah yeah, indeed. I'll fix these. (BTW. Could you CC Hugh next time as
> > he's the author).
> 
> I didn't see him Cc:d on the patch submission, and I'm guessing Josh did
> a reply-all. Seems as if the mailing list manager strips Cc fields of
> people already subscribed to the list, I've seen it before.

Yeah, my script for mailing quilt series doesn't do the selective CC
thingy... Bah, mpe wrote it, I suppose I can either nag him to fix it or
start learning perl :-)

Cheers,
Ben.
