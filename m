Return-Path: <fthain@telegraphics.com.au>
Received: from loopy.telegraphics.com.au (loopy.telegraphics.com.au
	[202.45.126.152]) by ozlabs.org (Postfix) with ESMTP id 2A89EDDEAB
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 23:30:13 +1000 (EST)
Date: Mon, 13 Aug 2007 23:09:30 +1000 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Subject: Re: [patch 10/10] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
In-Reply-To: <Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.64.0708132253530.21364@loopy.telegraphics.com.au>
References: <20070812094050.522858761@mail.of.borg>
	<20070812094119.910815432@mail.of.borg>
	<Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	debian-68k@lists.debian.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
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

> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible
> 
> With buttons emulation being available via uinput event devices, do we 
> still need the kernel mouse button emulation? At least on powerpc, it 
> was declared deprecated long ago ...
>
> Anyone using mouseemu on m68k Mac?

Yes, and on powermac too. It provides the paste key for gpm and I'm quite 
fond of it. But if there's a better alternative, I'll happily try it 
instead.

-f

> 
> 	Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
