Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0661B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 08:54:58 +1100 (EST)
Subject: Re: [PATCH V2 2/3] powerpc: Poll VPA for topology changes and
	update NUMA maps
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
In-Reply-To: <4CF6C32A.8000801@linux.vnet.ibm.com>
References: <20101109232436.17098.20055.sendpatchset@manic8ball.ltc.austin.ibm.com>
	<20101109232501.17098.55112.sendpatchset@manic8ball.ltc.austin.ibm.com>
	<1291002259.32570.274.camel@pasglop>
	<4CF6C32A.8000801@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Dec 2010 08:54:36 +1100
Message-ID: <1291240476.32570.397.camel@pasglop>
Mime-Version: 1.0
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, mjwolf@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-12-01 at 16:50 -0500, Jesse Larrew wrote:
> 
> Hmmm... Good point. That would eliminate a lot of complexity, and if
> we wrap the code in the timer interrupt so that it only executes on
> systems with the VPHN feature, then partition migration pretty much
> takes care of itself as well. :) I'll repost this patch set with the
> tweaks that you mentioned above, then I'll post a separate patch to
> remove the cpumask and timer.

Right. First fixup that patch and we can merge that, then we can look at
the "better approach" as a separate step.

Cheers,
Ben.
