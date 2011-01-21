Return-Path: <jdl@jdl.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Globally s/struct irq_host/struct irq_domain/ 
In-reply-to: <AANLkTi=bHV9XJoUT_ki1Eziq5fM3DekrOLoFuNzGGv91@mail.gmail.com> 
References: <E1Pd18R-0002d3-US@jdl.com>
	<20110121171314.GD7477@angua.secretlab.ca>
	<E1PgKdi-0005fc-J5@jdl.com>
	<AANLkTi=bHV9XJoUT_ki1Eziq5fM3DekrOLoFuNzGGv91@mail.gmail.com>
Date: Fri, 21 Jan 2011 12:02:28 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1PgLJc-0005rB-CP@jdl.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> I always reserve the right to change my mind.  }:-> 

Naturally!

> Sorry about that,

No problem.  The thought back then was that we'd hit the "global"
piece and then we'd buy the time to hit the local pieces as we could.

> but I actually applied the patch this morning with the thought that
> I'd get Linus to pick it up late to avoid collisions in linux-next.

Makes sense.

> However, when I actually looked at the result I realized that at the
> very least, the irq_host_ops, the #defines, and the irq_*_host
> functions absolutely have to be renamed at the same time.  Not
> necessarily in the same patch, but definitely at the same time.

Will do!

jdl
