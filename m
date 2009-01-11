Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (93-97-173-237.zone5.bethere.co.uk
	[93.97.173.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46217DDFC8
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 00:39:15 +1100 (EST)
Subject: Re: [GIT PULL] LED updates for 2.6.29
From: Richard Purdie <rpurdie@rpsys.net>
To: Trent Piepho <xyzzy@speakeasy.org>
In-Reply-To: <Pine.LNX.4.58.0901110416510.1626@shell2.speakeasy.net>
References: <1231500186.5317.9.camel@dax.rpnet.com>
	<Pine.LNX.4.64.0901091231310.22972@t2.domain.actdsltmp>
	<1231543199.5317.63.camel@dax.rpnet.com>
	<Pine.LNX.4.58.0901100428230.1626@shell2.speakeasy.net>
	<1231633983.5330.32.camel@dax.rpnet.com>
	<Pine.LNX.4.58.0901102138300.1626@shell2.speakeasy.net>
	<1231674559.5304.13.camel@dax.rpnet.com>
	<Pine.LNX.4.58.0901110416510.1626@shell2.speakeasy.net>
Content-Type: text/plain
Date: Sun, 11 Jan 2009 13:39:05 +0000
Message-Id: <1231681145.5304.31.camel@dax.rpnet.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Guennadi Liakhovetski <lg@denx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2009-01-11 at 04:58 -0800, Trent Piepho wrote:
> It doesn't seem right to merge someone's patches together, make a very
> small change, and then no longer credit them as the author.  Seems like it
> defeats the purpose of the SOB lines for tracing the train of custody too.
> If someone looks to see where the code came from, it will look like you
> wrote it.  Maybe Freescale will say Intel stole our code?  Without the SOB,
> what record is there in git that Freescale gave permission to put the code
> in the kernel?
> 
> I also put some significant effort into writing informative commit
> messages, which have been lost.  Along with Grant's acks for my patches.

It also doesn't make sense to make three changes adding different
interfaces and rearranging the same section of code three different
times. I'm dropping the patch, please send me a merged version of those
patches with a commit message you're happy with. If you want Acked-by
lines, we'll have to wait for them on the new patch as I'm going to do
this exactly by the book regardless of time pressures now. Please
indicate who you want Ack-ed by lines from so I know who to wait for.
Also, you'd better exclude the suspend/resume change and credit me for
the bitfield change, just to be 100% sure this is all legally accurate.

Regards,

Richard
