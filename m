Date: Tue, 16 Apr 2002 10:01:52 +0200
From: Olaf Hering <olh@suse.de>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ATI 7000 and dual-monitor X? (was Re: 9600 maturity?)
Message-ID: <20020416100152.A4692@suse.de>
References: <p05100303b8e0cf886762@[63.220.231.138]> <Pine.BSF.4.44.0204151224090.39853-100000@shell.unixbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.BSF.4.44.0204151224090.39853-100000@shell.unixbox.com>; from ajoshi@shell.unixbox.com on Mon, Apr 15, 2002 at 12:27:00PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 15, Ani Joshi wrote:

>
> On Mon, 15 Apr 2002, Stefan Jeglinski wrote:
>
> > http://www.ati.com/shopati/promotions/maccombo/index.html
> >
> > Seems like the 7000 would be a nice addition to spruce up my old
> > 9500/G3 workhorse. It would free up 2 slots as I now have a Twin
> > Turbo, an ixTV, and an old Matrox card in there now.
> >
> > 1. Is the Radeon 7000 supported in XFree86? Rather, the real question
> > is, does anyone know of any gotchas trying to run it in accelerated
> > mode?
>
> ATI tends to make new cards which are really just newer revisions of older
> ASICs.  For example, the Radeon 7200 is realy just a regular radeon with
> 64meg DDR (and perhaps higher clocks).  So its highly possible that the
> 7000 is a radeon VE (considering its dualhead).  If so, then it is
> supported.  Even if it isn't, adding support should be very trivial as it
> contains the same 1st generation Radeon ASIC.

It is a VE, but I have one report where it fails on a 9600, after
loading vgahw.a or something like that. Maybe it must go into another
slot or the guy has to boot without video=ofonly.
More details later..



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
