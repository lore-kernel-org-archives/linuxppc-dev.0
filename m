Date: Mon, 15 Apr 2002 12:27:00 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ATI 7000 and dual-monitor X? (was Re: 9600 maturity?)
In-Reply-To: <p05100303b8e0cf886762@[63.220.231.138]>
Message-ID: <Pine.BSF.4.44.0204151224090.39853-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 15 Apr 2002, Stefan Jeglinski wrote:

> http://www.ati.com/shopati/promotions/maccombo/index.html
>
> Seems like the 7000 would be a nice addition to spruce up my old
> 9500/G3 workhorse. It would free up 2 slots as I now have a Twin
> Turbo, an ixTV, and an old Matrox card in there now.
>
> 1. Is the Radeon 7000 supported in XFree86? Rather, the real question
> is, does anyone know of any gotchas trying to run it in accelerated
> mode?

ATI tends to make new cards which are really just newer revisions of older
ASICs.  For example, the Radeon 7200 is realy just a regular radeon with
64meg DDR (and perhaps higher clocks).  So its highly possible that the
7000 is a radeon VE (considering its dualhead).  If so, then it is
supported.  Even if it isn't, adding support should be very trivial as it
contains the same 1st generation Radeon ASIC.

> 2. What about the included USB TV - any hope for that working in X?

No idea on that one.

> 3. What is the status of dual monitors in XFree86? Last I remember,
> it could be made to work but only with fbdev - that running dual
> accelerated monitors was not really working.

Dualhead (accelerated) should work fine.



ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
