Subject: Re: aty128fb and EDID
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	Magnus Damm <damm@opensource.se>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.21.0302101034180.25020-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0302101034180.25020-100000@vervain.sonytel.be>
Content-Type: text/plain
Message-Id: <1044873260.11921.24.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 10 Feb 2003 11:34:20 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-02-10 at 10:35, Geert Uytterhoeven wrote:
> On Sun, 9 Feb 2003, Kevin B. Hendricks wrote:
> > Steal the code from the radeon dirver in the kernel.  It finds and parses
> > the EDID block in OF for ppc linux systems for LCD.
>
> I guess you actually meant:
>
> | Move the code out of the radeon driver and make it sufficiently generic so it
> | can be used by the aty128 and other drivers?

That code is also shared by rivafb. It's rather LCD/DFP specific for
now, I would _much_ prefer some more generic EDID parser. So far,
I haven't been able to find any specification of the edid block,
this is annoying as I'd like to deduce a proper default mode for
CRTs as well, and some informations about backlight ranges (if any
in the EDID).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
