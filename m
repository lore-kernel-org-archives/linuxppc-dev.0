Date: Mon, 4 Nov 2002 16:49:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IDE on LongTrail
Message-ID: <20021104234953.GD13102@opus.bloom.county>
References: <Pine.GSO.4.21.0211032047160.12607-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0211032047160.12607-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Nov 03, 2002 at 10:40:42PM +0100, Geert Uytterhoeven wrote:

> I just tried adding an IDE disk to mine. The disk is identified correctly, but
> I always get `hda: lost interrupt' for any other operation. According to lspci
> the sl82c105 uses IRQ 32 (OpenPIC), but /proc/interrupt shows no interrupts
> coming in there.

WHich kernel?  It worked on mine as of 2.4.18'ish I believe.  2.5 has
known problems with that driver in general, which RMK has on his to fix
list.

> I'm using 2.4.20-rc1 (from linuxppc_2_4).

I see.  Uh-oh.  I'll have to compile up a new kernel and give it a shot
this week..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
