Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E80CADDDFA
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 18:02:09 +1100 (EST)
Subject: Re: [PATCH 18/25] powerpc: Base support for 440GX Taishan eval board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206211758.6f086161@zod.rchland.ibm.com>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080129.737E8DE09F@ozlabs.org>
	<20071206211758.6f086161@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 18:01:55 +1100
Message-Id: <1197183715.6572.8.camel@pasglop>
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


> > +config TAISHAN
> > +	bool "Taishan"
> > +	depends on 44x
> > +	default n
> > +	select 440GX
> > +	help
> > +	  This option enables support for the IBM PPC440GX "Taishan" evaluation board.
> 
> AMCC Taishan board.

Ah yeah, indeed. I'll fix these. (BTW. Could you CC Hugh next time as
he's the author).
 
> > +			/* Ebony has all 4 IRQ pins tied together per slot */
> 
> This isn't an Ebony board.  Does Taishan do the same?

The comment is bogus, the mapping is correct (and doesn't match the
comment, I just forgot to remove it after copy/pasting :-)

Ben.
