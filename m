Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1F98DDDE6
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 13:44:30 +1000 (EST)
Subject: Re: "next" branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40906012026r71b3b75ar13790f7a569d9c08@mail.gmail.com>
References: <1243911828.5308.2.camel@pasglop>
	<fa686aa40906012026r71b3b75ar13790f7a569d9c08@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Jun 2009 13:44:23 +1000
Message-Id: <1243914263.5308.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-06-01 at 21:26 -0600, Grant Likely wrote:
> How about the iomap_early() patch?  What would you like me to do with
> that one?

Wait for me to review it :-)

Cheers,
Ben.

> g.
> 
> > On Jun 1, 2009 9:04 PM, "Benjamin Herrenschmidt"
> > <benh@kernel.crashing.org> wrote:
> > 
> > I've updated powerpc "next branch" with the following patches:
> > 
> > (Kumar: The swiotlb patch is still segregated in "test" until we
> > resolve
> > how it's going to be merged vs. Ian Campbell series).
> > 
> > Anton Blanchard (1):
> >      powerpc: Convert RTAS event scan from kernel thread to
> > workqueue
> > 
> > Michael Ellerman (3):
> >      powerpc/ftrace: Use ppc_function_entry() instead of GET_ADDR
> >      powerpc/ftrace: Remove unused macros
> >      powerpc/ftrace: Use PPC_INST_NOP directly
> > 
> > Michael Neuling (1):
> >      powerpc: Make the NR_CPUS max 8192
> > 
> > Michel Dänzer (1):
> >      therm_adt746x: Always clear hardware bit which inverts fan
> > speed range.
> > 
> > Nathan Fontenot (1):
> >      powerpc: Display processor virtualization resource allocs in
> > lparcfg
> > 
> > Stephen Rothwell (1):
> >      powerpc/pci: Fix annotation of pcibios_claim_one_bus
> > 
> > roel kluin (1):
> >      tape: beyond ARRAY_SIZE of viocd_diskinfo
> > 
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
