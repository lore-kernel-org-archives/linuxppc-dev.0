Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29C03DDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 15:32:48 +1000 (EST)
Subject: Re: Updates to powerpc.git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1215588881.8970.358.camel@pasglop>
References: <1215588881.8970.358.camel@pasglop>
Content-Type: text/plain
Date: Mon, 14 Jul 2008 15:32:36 +1000
Message-Id: <1216013556.7549.244.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 17:34 +1000, Benjamin Herrenschmidt wrote:
> 
> It contains 3 branches:
> 
>   - merge  : this is for merging with the current stable and doesn't
>              currently contain anything interesting
> 
>   - master : this is our current "powerpc.git" tree, it may contain
>              various experimental stuff that may or may not go upstream
>              or may contain dependent patches that we rely on but that
>              are to be merged via some other tree.
> 
>   - next   : this is the candidate stuff for linux-next and the next
>              merge window

-next and -merge are now both to the same level, which is the same
as I pushed last week plus a merge with 2.6.26 to resolve a conflict.

I'll start putting new stuff in tomorrow if all goes well.

Cheers,
Ben.
