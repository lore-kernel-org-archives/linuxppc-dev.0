Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65D7FB6ED0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2011 08:49:18 +1100 (EST)
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <AANLkTinLb0sg1H6GDbZiddqGQ4a0=GRLYFJbL0G1Kv62@mail.gmail.com>
References: <1300427072.22236.1277.camel@pasglop>
	<AANLkTinLb0sg1H6GDbZiddqGQ4a0=GRLYFJbL0G1Kv62@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 19 Mar 2011 08:48:54 +1100
Message-ID: <1300484934.22236.1285.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-03-18 at 06:34 -0700, Linus Torvalds wrote:
> > Here are the changes for this merge window for powerpc. One highlight
> > is irq data conversion so we can get rid of the legacy stuff. The new
> > Dynamic DMA windows for pSeries should also improve performances for
> > some devices nicely on more recent machines/firmwares. Plus a little
> > pack of embedded things.
> 
> Ok, I got a conflict with the of_platform_driver() removal which
> looked pretty trivial, but since I don't have a ppc cross-compile
> thing I couldn't even test-compile the end result. Please take a look
> to see that it went ok..

Ok, I'll have a look later today.

Thanks,
Ben.
