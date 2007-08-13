Return-Path: <schmitz@mail.biophys.uni-duesseldorf.de>
Received: from opal.biophys.uni-duesseldorf.de
	(opal.biophys.uni-duesseldorf.de [134.99.176.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.biophys.uni-duesseldorf.de",
	Issuer "mail.biophys.uni-duesseldorf.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 77F94DDF60
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Aug 2007 22:45:23 +1000 (EST)
Date: Mon, 13 Aug 2007 14:36:55 +0200 (CEST)
From: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 10/10] m68k/mac: Make mac_hid_mouse_emulate_buttons()
	declaration visible
In-Reply-To: <20070812094119.910815432@mail.of.borg>
Message-ID: <Pine.LNX.4.58.0708131432560.32732@om.biophys.uni-duesseldorf.de>
References: <20070812094050.522858761@mail.of.borg>
	<20070812094119.910815432@mail.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Cc: linux-m68k@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	debian-68k@lists.debian.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-input@atrey.karlin.mff.cuni.cz,
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

> From: Geert Uytterhoeven <geert@linux-m68k.org>
>
> m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible

With buttons emulation being available via uinput event devices, do we
still need the kernel mouse button emulation? At least on powerpc, it was
declared deprecated long ago ...

Anyone using mouseemu on m68k Mac?

	Michael
