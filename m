Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D157ADDDFF
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 18:05:03 +1100 (EST)
Subject: Re: [PATCH 21/25] powerpc: Adds decoding of 440SPE memory size to
	boot wrapper library
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206212235.4ff38139@zod.rchland.ibm.com>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080132.0CCE9DE109@ozlabs.org>
	<20071206212235.4ff38139@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 18:04:48 +1100
Message-Id: <1197183888.6572.14.camel@pasglop>
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


On Thu, 2007-12-06 at 21:22 -0600, Josh Boyer wrote:
> On Thu, 06 Dec 2007 19:00:20 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > This adds a function to the bootwrapper 4xx library to decode memory
> > size on 440SPE processors.
> 
> Why did you rename the fixup_memsize function?  Could you add that to
> the changelog, and perhaps a bit about adding the SDRAM0_{READ,WRITE}
> macros

Because there's 3 fixup_*_memsize functions, felt it would be better
that they all have distinctive names no ? I don't see the need of
altering the changelog tho... If you don't know what those macros stand
for you probably should stay clear from those registers anyway.

Ben.
