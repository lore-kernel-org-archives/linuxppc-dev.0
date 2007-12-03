Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EB95DDE36
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 14:27:00 +1100 (EST)
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI, PCI-X and PCI-Express support
	among others
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071130141756.3aa3d38b@zod.rchland.ibm.com>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130141756.3aa3d38b@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 14:24:30 +1100
Message-Id: <1196652270.13230.192.camel@pasglop>
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


On Fri, 2007-11-30 at 14:17 -0600, Josh Boyer wrote:
> > Some of these patches are _NOT_ yet candidate for merging
> > (mostly the board support ones), but you can review them and
> > Josh can put them in an experimental tree.
> 
> I've added these to the 2.6.25-candidates branch in my tree.  Fixed up
> the few conflicts manually.  I'll expect refreshes before merging
> anyway, but I'd like to get these out there for people to play with.

BTW. You were telling me the other day about a problem with the clock
code. 

It looks like the problem is a subtle difference between 440EP /440EPx
and 440SPe / 440GX. The former has the EBC clock derived from the PLB
clock while the later has it derived from OPB... yuck.

I'm fixing that.

Cheers,
Ben.
