Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EEBCDDE44
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 09:29:32 +1000 (EST)
Subject: Re: [PATCH/RFC] Rework ptep_set_access_flags and fix sun4c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070522.145340.59657045.davem@davemloft.net>
References: <1179757647.6254.235.camel@localhost.localdomain>
	<1179815339.32247.799.camel@localhost.localdomain>
	<Pine.LNX.4.61.0705222247010.5890@mtfhpc.demon.co.uk>
	<20070522.145340.59657045.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 23 May 2007 09:29:14 +1000
Message-Id: <1179876554.32247.889.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: mark@mtfhpc.demon.co.uk, linux-mm@kvack.org, wli@holomorphy.com,
	linuxppc-dev@ozlabs.org, andrea@suse.de, tcallawa@redhat.com,
	sparclinux@vger.kernel.org, hugh@veritas.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 14:53 -0700, David Miller wrote:
> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Tue, 22 May 2007 22:52:13 +0100 (BST)
> 
> > Hi Benjamin,
> > 
> > I have just tested this patch on my Sun4c Sparcstation 1 using my 2.6.20.9 
> > test kernel without any problems.
> > 
> > Thank you for the work.
> 
> Thanks for your testing.
> 
> Someone please merge this in once any remaining issues have
> been resolved :-)

I'll send a patch fixing the couple of x86/ia64 nits & my bad english
spelling (no, I don't happen to raise castrated rams) as soon as I reach
the office later today.

Cheers,
Ben.
