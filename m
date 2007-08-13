Return-Path: <schmitz@mail.biophys.uni-duesseldorf.de>
Received: from opal.biophys.uni-duesseldorf.de
	(opal.biophys.uni-duesseldorf.de [134.99.176.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.biophys.uni-duesseldorf.de",
	Issuer "mail.biophys.uni-duesseldorf.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6EC84DDEE4
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 23:35:52 +1000 (EST)
Date: Mon, 13 Aug 2007 15:35:04 +0200 (CEST)
From: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [patch 10/10] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
In-Reply-To: <Pine.LNX.4.64.0708132253530.21364@loopy.telegraphics.com.au>
Message-ID: <Pine.LNX.4.58.0708131531440.585@om.biophys.uni-duesseldorf.de>
References: <20070812094050.522858761@mail.of.borg>
	<20070812094119.910815432@mail.of.borg>
	<Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
	<Pine.LNX.4.64.0708132253530.21364@loopy.telegraphics.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Cc: linux-m68k@vger.kernel.org,
	Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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

> > Anyone using mouseemu on m68k Mac?
>
> Yes, and on powermac too. It provides the paste key for gpm and I'm quite
> fond of it. But if there's a better alternative, I'll happily try it
> instead.

Too much overhead on m68k? On powermac it never gave me trouble, but I was
surprised to hear people use it on m68k.

If it works OK, we can really drop the kernel support.

	Michael
