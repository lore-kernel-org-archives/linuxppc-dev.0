Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D36C5DDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 17:15:58 +1000 (EST)
Subject: Re: [PATCH] powerpc: Pegasos keyboard detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070726212241.032e9755.akpm@linux-foundation.org>
References: <200707250128.l6P1SWSF1336935@shell01.TheWorld.com>
	<1185347565.5439.310.camel@localhost.localdomain>
	<20070726184800.0bb3b9fb.akpm@linux-foundation.org>
	<1185505222.5495.182.camel@localhost.localdomain>
	<20070726212241.032e9755.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Fri, 27 Jul 2007 17:15:47 +1000
Message-Id: <1185520547.5495.192.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Alan Curry <pacman@theworld.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-26 at 21:22 -0700, Andrew Morton wrote:
> 
> > Merged a fixed version:
> > 
> > f5d834fc34e61f1a40435981062000e5d2b2baa8
> > 
> > (In linus tree as of now)
> 
> I hope so.  Alan's patch looks rather different from what you have
> now:
> fall back to of_find_node_by_name() if of_find_node_by_type() failed.

Which is just waht that commit does :-)

Ben.
