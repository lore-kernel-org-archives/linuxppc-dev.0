Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 04BE0474C8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 07:51:44 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix missing semicolons in mmu_decl.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090107143724.GF17171@zod.rchland.ibm.com>
References: <20090107035702.C9114474D7@ozlabs.org>
	<20090107143724.GF17171@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 07:51:37 +1100
Message-Id: <1231361497.2142.20.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-07 at 09:37 -0500, Josh Boyer wrote:
> On Wed, Jan 07, 2009 at 02:56:51PM +1100, Benjamin Herrenschmidt wrote:
> >This is a brown paper bag from one of my earlier patches that
> >breaks build on 40x and 8xx.
> >
> >And yes, I've now added 40x and 8xx to my list of test configs :-)
> >
> >Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Please get it into your tree so people stop emailing me about it
> being broken :).

It's in, waiting for me to push. I didn't have a chance yesterday due to
other problems but hopefully, after I do a few boot tests today, I'll
push out.

Ben.
