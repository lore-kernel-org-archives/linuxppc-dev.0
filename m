Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED7C4B7BA5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Oct 2009 08:23:10 +1100 (EST)
Subject: Re: [PATCH][v2] powerpc/4xx: Add 16K FIFO size DTS entries on
	supported platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20091009115042.GC22408@zod.rchland.ibm.com>
References: <1255019609-2033-1-git-send-email-dmitchell@appliedmicro.com>
	<1255054554.2355.28.camel@pasglop>
	<20091009115042.GC22408@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 10 Oct 2009 08:22:51 +1100
Message-Id: <1255123371.2861.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Dave Mitchell <dmitchell@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-09 at 07:50 -0400, Josh Boyer wrote:
> On Fri, Oct 09, 2009 at 01:15:54PM +1100, Benjamin Herrenschmidt wrote:
> >On Thu, 2009-10-08 at 11:33 -0500, Dave Mitchell wrote:
> >> Adding tx/rx-fifo-size-gige to EMAC fields for evaluation kit DTS
> >> files where appropriate.
> >> 
> >> Signed-off-by: Dave Mitchell <dmitchell@appliedmicro.com>
> >> Acked-by: Prodyut Hazarika <phazarika@appliedmicro.com>
> >> Acked-by: Victor Gallardo <vgallardo@appliedmicro.com>
> >> Acked-by: Loc Ho <lho@appliedmicro.com>
> >> ---
> >>  v1->v2: local date/time was out-of-sync and thus mail was as well
> >
> >I'll have to wait for the EMAC patch to go in, so ping me if you don't
> >see me take that one after that happens.
> 
> I have some other DTS changes I'll be making soon.  Mind if I pick it up
> in my tree to avoid headaches?  I will, of course, wait until the EMAC
> patch is merged.

Sure. Just assign it to yourself in PW

Cheers,
Ben.
