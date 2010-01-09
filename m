Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id E311FB7C23
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Jan 2010 19:17:35 +1100 (EST)
From: Rob Landley <rob@landley.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Re: ZILOG serial port broken in 2.6.32
Date: Sat, 9 Jan 2010 02:17:23 -0600
References: <200912060101.22515.rob@landley.net>
	<200912080642.52103.rob@landley.net>
	<1262919644.2173.704.camel@pasglop>
In-Reply-To: <1262919644.2173.704.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201001090217.25729.rob@landley.net>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 07 January 2010 21:00:43 Benjamin Herrenschmidt wrote:
> > Ok, here's the fix.  It's not the _right_ fix, but it Works For Me (tm)
> > and I'll leave it to you guys to figure out what this _means_:
>
> I've failed to reproduce so far on both a Wallstreet powerbook (similar
> generation and chipset as your beige G3) and a G5 with an added serial
> port using current upstream...
>
> Can you verify it's still there ? I might be able to reproduce on a
> Beige G3 as well next week.

It's still there on qemu 0.11.0's "g3beige" emulation when you use 
CONFIG_SERIAL_PMACZILOG as the serial console.  (QEMU 0.10.x used a 16550 
serial chip for its g3beige emulation instead of the actual ZILOG one.)  Still 
dunno if it's a qemu or bug or a kernel bug, I just know that kernel patch 
fixes it for me, and it comes back without the patch.

I tested 2.6.32.  Haven't tried the 2.6.32.3 but don't see why it would change 
this...

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
