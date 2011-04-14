Return-Path: <acrux_it@libero.it>
Received: from cp-out11.libero.it (cp-out11.libero.it [212.52.84.111])
	by ozlabs.org (Postfix) with ESMTP id 35139B6F4E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 02:39:39 +1000 (EST)
Date: Thu, 14 Apr 2011 18:39:31 +0200
From: acrux <acrux_it@libero.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerMacintosh B&W G3 boot failure - linux-2.6.36.x
Message-Id: <20110414183931.26cfc02f.acrux_it@libero.it>
In-Reply-To: <1302749356.28876.105.camel@pasglop>
References: <20110413202714.ad1b5697.acrux_it@libero.it>
	<1302749356.28876.105.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Nello M <ppc.addon@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Apr 2011 12:49:16 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-04-13 at 20:27 +0200, acrux wrote:
> > i guess it's a different problem from the PegasosI G3 but i could
> > be wrong.
> > 
> > I'd like to receive  feedbacks and a working kernel config if
> > someone is running with success linux-2.6.26.x on a Pmac B&W G3.
> > This machine, altough obsolete, is still quite common
> 
> The snapshot you posted doesn't have much information... there's no
> obvious error for example in there...
> 

I know, I received from it from a user. It's where the kernel hangs.

Anyway, the last year, i received many install failures report from
cruxppc users. I hope it's only my fault building the bootkernel and
i'd like to receive a feedback from others distro developers for this
specific machine.

I always avoided to collect obsolete machines thus I don't have a B&W G3
but now i'm looking for one.

> What video driver are you trying to use ? Have you tried plain offb ?
> (disabling whatever is the native driver for your video card, ie,
> radeonfb or aty128fb or even atyfb, dunno what you have in there).
> 
> You can also try something like "udbg-immortal" on the kernel command
> line see if that brings you more debug output.
> 

I'll try to receive more detailed info from that gentle user.

Thanks again for your kind support,
Nico
-- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.org/
