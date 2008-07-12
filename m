Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 569DFDDEF5
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 13:47:42 +1000 (EST)
Subject: Re: linux-next: manual merge of the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200807112101.25704.bzolnier@gmail.com>
References: <20080707230717.10429faf.sfr@canb.auug.org.au>
	<200807112101.25704.bzolnier@gmail.com>
Content-Type: text/plain
Date: Sat, 12 Jul 2008 13:41:30 +1000
Message-Id: <1215834090.7549.149.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Walker <dwalker@mvista.com>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-11 at 21:01 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Since I haven't heard back from Ben [1] on ide-pmac/media-bay IRQ issue
> I took another look at ide-pmac patches and I think that it should be
> possible to rework them in such way that consecutive ide patches (> 100)
> won't depend on "ide-pmac: media-bay support fixes (take 4)" patch.
> 
> This would allow us to re-schedule it to 2.6.28 (which is probably what
> we want because 2.6.26 is probably just around the corner and we will be
> pretty busy with 2.6.27 merge window soon).  Ben, what's your opinion?
> 
> [1] which doesn't surprise me given his new responsibilities ;)

That and I just moved house... been hectic lately.

I'll give another shot at the IRQ issues early next week, and if it
still doesn't work, we'll postpone.

Cheers,
Ben.
