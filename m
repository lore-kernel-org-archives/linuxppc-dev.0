Date: Thu, 7 Nov 2002 11:37:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: screen_info in 2.4.20-rc1
Message-ID: <20021107183739.GA6164@opus.bloom.county>
References: <Pine.GSO.4.21.0211071816370.3669-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0211071816370.3669-100000@vervain.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 07, 2002 at 06:21:09PM +0100, Geert Uytterhoeven wrote:

> In 2.4.20-rc1, the declaration and export of screen_info[] depends on
> CONFIG_VGA_CONSOLE. However, it's also needed by vga16fb, which can be modular
> as well.

This is fixed in _devel (along with vesafb) and in 2.5.  It was just
over looked for 2.4.20 I suppose.  It's a low impact change, so I doubt
Paul would object to trying to get Marcelo to take it.

Paul?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
