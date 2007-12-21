Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D471DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 09:14:39 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBLMGKD0028465
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 17:16:20 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBLMEZrG478178
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 17:14:35 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBLMEYYm014987
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 17:14:35 -0500
Date: Fri, 21 Dec 2007 16:08:45 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 18/21] [POWERPC] bamboo: remove bogus "ranges" property
	in EBC node
Message-ID: <20071221160845.331f35f6@zod.rchland.ibm.com>
In-Reply-To: <1198271815.6737.4.camel@pasglop>
References: <20071221043939.72A8BDDFCF@ozlabs.org>
	<20071221060921.4ae5bc20@zod.rchland.ibm.com>
	<1198271815.6737.4.camel@pasglop>
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

On Sat, 22 Dec 2007 08:16:55 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2007-12-21 at 06:09 -0600, Josh Boyer wrote:
> > On Fri, 21 Dec 2007 15:39:35 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > This removes a bogus empty "ranges" property in the EBC device node
> > > of the Bamboo board device-tree.
> > > 
> > > The "ranges" property will be created by the boot wrapper, there is
> > > no need to have an empty property there, and that causes recent
> > > dtc to complain.
> > 
> > The wrapper doesn't do anything with EBC for bamboo because the EBC
> > stuff is a nightmare on this board.  The patch can stand, but I'll
> > fixup the comments in the changelog.
> 
> The wrapper could still create ranges for the chip select settings no ?

It could.  It doesn't though.  Perhaps our interpretation of "will be
created" differed.

> In any case, empty "ranges" is bogus.

Correct.  Which is why I said I'd just edit the changelog :).

josh
