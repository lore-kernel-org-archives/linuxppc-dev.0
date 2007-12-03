Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0DAEADDE49
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 15:22:34 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB34MVwb009634
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 23:22:31 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB34MUT4123588
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 21:22:30 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB34MUf7022909
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 21:22:30 -0700
Date: Sun, 2 Dec 2007 22:20:22 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI, PCI-X and PCI-Express support
	among others
Message-ID: <20071202222022.45839409@zod.rchland.ibm.com>
In-Reply-To: <1196652270.13230.192.camel@pasglop>
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130141756.3aa3d38b@zod.rchland.ibm.com>
	<1196652270.13230.192.camel@pasglop>
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

On Mon, 03 Dec 2007 14:24:30 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Fri, 2007-11-30 at 14:17 -0600, Josh Boyer wrote:
> > > Some of these patches are _NOT_ yet candidate for merging
> > > (mostly the board support ones), but you can review them and
> > > Josh can put them in an experimental tree.
> > 
> > I've added these to the 2.6.25-candidates branch in my tree.  Fixed up
> > the few conflicts manually.  I'll expect refreshes before merging
> > anyway, but I'd like to get these out there for people to play with.
> 
> BTW. You were telling me the other day about a problem with the clock
> code. 
> 
> It looks like the problem is a subtle difference between 440EP /440EPx
> and 440SPe / 440GX. The former has the EBC clock derived from the PLB
> clock while the later has it derived from OPB... yuck.

Yes.

> I'm fixing that.

Ok.

josh
