Date: Wed, 12 Dec 2001 12:21:02 -0700
From: Matt Porter <mporter@mvista.com>
To: Kent Borg <kentborg@borg.org>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Compile Penguin PPC for x386?
Message-ID: <20011212122102.B21676@cx258813-a.chnd1.az.home.com>
References: <20011212165819.D1790@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011212165819.D1790@borg.org>; from kentborg@borg.org on Wed, Dec 12, 2001 at 04:58:19PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 12, 2001 at 04:58:19PM -0500, Kent Borg wrote:
>
> Is the i386 arch vaguely up to date in the PPC tree?  Does it work?
>
> I mean, if I want to debug some driver that doesn't need actual
> hardware (maybe dummy out actual HW banging), can I swap over to
> building an i386 kernel?  It would be nice to be using the same
> kernel.
>
> If I can do that, how?  In Makefile I changed "ARCH" to i386, changed
> "CROSS_COMPILE" to be nothing, did a "make mrproper", copied in a
> .config from my Red Hat install, defaulted everything asked by "make
> oldconfig", did "make dep", and "make bzImage".
>
> But then it chokes on some problem in include/linux/highmem.h (48:
> parse error before `0').
>
> Should this work?

No, the PPC MM changes in 2_4_devel rely on changes to the generic
MM API that aren't yet in the kernel.org release.  You could modify
the appropriate files in arch/i386/mm/ and include/asm-i386/ to match
if you like.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
