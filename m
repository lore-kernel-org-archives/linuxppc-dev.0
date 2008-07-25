Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD4CDDDF31
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 07:40:16 +1000 (EST)
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C786174A-78C1-40B6-ABC9-24E7419FA182@kernel.crashing.org>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
	<20080723115321.53aa655b@zod.rchland.ibm.com>
	<1216829442.5727.97.camel@gargoyle> <1216958433.11188.70.camel@pasglop>
	<C786174A-78C1-40B6-ABC9-24E7419FA182@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 26 Jul 2008 07:37:54 +1000
Message-Id: <1217021874.11188.108.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 10:23 -0500, Kumar Gala wrote:
> 
> Ben,  I want to make sure this works on FSL Book-E before it gets into  
> tree and I need to think about what SMP issues it might have.

Hrm.. too late. I merged it.

> I talked to Josh about this at OLS and if you are ok I can deal with  
> acceptance of this patch via my tree.

I don't see the patch causing issues as-is, unless I missed something.
Currently none of the platform it affects supports SMP in the tree
either. Can you verify about FSL and if there's a problem we can fixup
the #ifdefs.

Ben.
