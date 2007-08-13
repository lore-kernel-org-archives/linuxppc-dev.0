Return-Path: <geert@linux-m68k.org>
Received: from ananke.telenet-ops.be (ananke.telenet-ops.be [195.130.137.78])
	by ozlabs.org (Postfix) with ESMTP id AC864DDF05
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 23:57:32 +1000 (EST)
Date: Mon, 13 Aug 2007 15:57:28 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: [patch 10/10] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
In-Reply-To: <Pine.LNX.4.58.0708131531440.585@om.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.64.0708131552400.8645@anakin>
References: <20070812094050.522858761@mail.of.borg>
	<20070812094119.910815432@mail.of.borg>
	<Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
	<Pine.LNX.4.64.0708132253530.21364@loopy.telegraphics.com.au>
	<Pine.LNX.4.58.0708131531440.585@om.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	debian-68k@lists.debian.org, linux-kernel@vger.kernel.org,
	Finn Thain <fthain@telegraphics.com.au>, linuxppc-dev@ozlabs.org,
	linux-input@atrey.karlin.mff.cuni.cz,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Aug 2007, Michael Schmitz wrote:
> > > Anyone using mouseemu on m68k Mac?
> >
> > Yes, and on powermac too. It provides the paste key for gpm and I'm quite
> > fond of it. But if there's a better alternative, I'll happily try it
> > instead.
> 
> Too much overhead on m68k? On powermac it never gave me trouble, but I was
> surprised to hear people use it on m68k.
> 
> If it works OK, we can really drop the kernel support.

If it can be removed completely, for PowerMac, Mac/m68k, and IntelliMac (or
whatever it's called), fine for me!  Please coordinate with the other
Mac people.

But for now, Linus, please apply, as the missing prototype causes a
broken Mac/m68k build.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
