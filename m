Date: Tue, 21 Mar 2000 21:08:28 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: anthony tong <atong@uiuc.edu>
cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches to fix aty128fb and xf400 r128 to work with both Rage128
 and Rage128Pros
In-Reply-To: <20000321112355.A5368@rogue.genunix.net>
Message-ID: <Pine.LNX.4.21.0003212100450.1173-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 21 Mar 2000, anthony tong wrote:

> Kostas Gewrgiou (Tue, Mar 21, 2000 at 06:56:25PM +0200):
> >  From the patches i see that the reference freq is still assumed to be
> > 29.50Mhz
> >      /* Assume REF clock is 2950 (in units of 10khz) */
> >      /* and that all pllclk must be between 125 Mhz and 250Mhz */
> >      pll->reference_freq = 2950;
> >      pll->min_pll_freq   = 12500;
> >      pll->max_pll_freq   = 25000;
> >
> >  From the comments in the xfree driver (and the ati docs) this isn't always
> > true:
> >      /* These probably aren't going to work for
> >         the card you are using.  Specifically,
> >         reference freq can be 29.50MHz,
> >         28.63MHz, or 14.32MHz.  YMMV. */
>
> I think that we can assume a 29.50 clock *for now*; lower clocks are
> probably for future low powered/mobile versions of the chip.
>

  Well in my x86 machine the ati card uses a lower clock now
if cards with a clock different than 29.50MHz are used in Macs
or not is another matter.

(--) r128(0): Chipset: "ATI Rage 128 RF (AGP)" (ChipID = 0x5246)
(--) r128(0): VideoRAM: 32768 kByte (64-bit SDR SGRAM 2:1)
(II) r128(0): PLL parameters: rf=1432 rd=31 min=12500 max=25000; xclk=6000

>
> -at


 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
