Date: Thu, 12 Oct 2000 19:11:23 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
cc: Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <200010121430.JAA21005@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.21.0010121849230.1017-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Hendricks, Kevin wrote:

> A lookup table would certainly do the trick if the user did not want to
> simply  use trial and error.  Anything would be better than the complete
> hard coded values set in the XF 4.0 source.
>
> Perhaps a better idea is allow the REF clock rate to be passed as a
> parameter in the XF86Config file (much like the video memory parameter and
> bus ids passed now) for people to have control over if need be.   This
> value would then only be used if the bios test failed and then in place of
> the hardcoded values so that my pll register probing routine would be
> actually work.  A desperate user could then try each of the 3 values until
> he/she saw something they liked on the screen.

I prefer to use a lookup table before the config option, most users will
have no idea how to play with the options. I wonder if someone can damage
his card with a bad reference freq setup...

> > Most of the ppc r128 cards have a reference frequency of 29.50MHz so the
> > code works but i heard that some of the new ones have different reference
> > freq.
>
> Yes, there is one new card (of the r128 variety) on Ben's list that does
> not use the 2950 ref clock value.

The new r128 code needs to read extra values from the rom for the flatpanel
setup as well (Michel knows more about this) which we will have to find a
solution too.

> Since he has a bios on a ppc card it would be interesting to see the
> results of some "bios present?" tests to help determine if a bios is
> really there or not.  The current test sometimes passes on macs without a
> bios (possibly OF rom?) and garbage values are returned.

The current test only checks if a rom is present not if a bios or OF segment
is there, it needs to be fixed to check that its really reading from a
bios rom and not from something else (OF).

 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
