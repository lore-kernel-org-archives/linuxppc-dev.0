Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BFEC62C0334
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 17:39:27 +1000 (EST)
Message-ID: <1343029161.2957.35.camel@pasglop>
Subject: Re: [PATCH] powerpc: Update g5_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Mon, 23 Jul 2012 17:39:21 +1000
In-Reply-To: <m2boj7ym24.fsf@igel.home>
References: <1343011712.2957.5.camel__22210.4697292254$1343011753$gmane$org@pasglop>
 <m2fw8jyn43.fsf@igel.home> <1343027168.2957.30.camel@pasglop>
 <m2boj7ym24.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ben Skeggs <bskeggs@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 09:27 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > What do you mean by "lots of problems" ?
> 
> For example, only half of the screen is drawn.  There is a bug open
> about this, but no comments.
> 
> > Also can you remind me what machine model and what video card variant ?
> 
> PowerMac7,3 with NV34 [GeForce FX 5200 Ultra] (rev a1).

Ah ok, I haven't seen these problems.

Ben, any idea ? I was trying to make nouveau the default instead of
nvidiafb on G5's but it seems like some old G5's with those NV34 aren't
happy.

BTW. Are we trying to use AGP on these things ? If yes, I would suggest
we just blacklist AGP on all powermac unless specifically requested via
a kernel command line arg. That would be half of the problems solved...

I have access to an iMac G5 with an old 5200 variant as well which I
could dig out & try if there's anything I can do to help debug that.

(On my G5s it's all PCIe so that problem doesn't happen).

Cheers,
Ben.
