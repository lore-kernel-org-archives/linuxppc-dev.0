Date: Thu, 30 Sep 1999 11:41:17 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Joerg Rambau <rambau@zib.de>
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org, tas@mindspring.com
Subject: Re: SndConfig for Linux/PPC
In-Reply-To: <37F32EBC.FAFD82E2@zib.de>
Message-ID: <Pine.GSO.4.10.9909301138500.8003-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 30 Sep 1999, Joerg Rambau wrote:
> I have a Rev 2 PB G3 266 MHz (bought in Dec 98)
> with Rage LT Pro, Chip ID 0x4c50.

> MCLK 78, PLL 135 crashes (and some others I cannot remember),
> MCLK 60, 63, 71, PLL 135, MCLK 100, PLL DEFAULT do not crash.
> 
> I have to say that, in contrast to earlier versions of atyfb.c,
> MCLK 100, PLL DEFAULT

Why try PLL 135?

AFAIK the RAGE PRO LT PLL upper limit is 230 Mhz. This means that the PLL locks
best in the range 115-230 MHz. Outside this range, the PLL may not lock to the
specified frequency. If you use PLL 135, atyfb will assume the PLL locks best
in the range 62.5-135 MHz, which may cause screen unstabilities.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
