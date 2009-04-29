Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67B3DDDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 05:58:52 +1000 (EST)
Subject: Re: [PATCH 1/6] powerpc: Move #ifdef'ed body of do_IRQ() into a
	separate function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C9C597A9-3096-4BF1-8559-15FADFB2AEAD@kernel.crashing.org>
References: <c3e0e417a708c5d76d9f4130e5f2b0398a1e0c3e.1240450296.git.michael@ellerman.id.au>
	<20090425181823.GA10481@lst.de> <1240879747.11027.2.camel@localhost>
	<20090429114448.GA13129@lst.de>
	<C9C597A9-3096-4BF1-8559-15FADFB2AEAD@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 30 Apr 2009 05:58:36 +1000
Message-Id: <1241035116.16444.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-29 at 07:48 -0500, Kumar Gala wrote:
> 
> I think Ben, Paul and I had discussed just universally enabling it.   
> Can't remember why Ben hadn't done that yet.

Slipped between the cracks. Patch welcome.

Cheers,
Ben.
