Date: Wed, 20 Sep 2000 09:31:10 -0700
From: Matt Porter <mporter@mvista.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Message-ID: <20000920093110.C30600@beef.az.mvista.com>
References: <20000919150621.A9826@cx258813-a.chnd1.az.home.com> <Pine.LNX.4.10.10009201408040.389-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10009201408040.389-100000@cassiopeia.home>; from geert@linux-m68k.org on Wed, Sep 20, 2000 at 02:08:42PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 20, 2000 at 02:08:42PM +0200, Geert Uytterhoeven wrote:
> On Tue, 19 Sep 2000, Matt Porter wrote:
> > would only be used on the "primary" host bridge.  I realize there
> > are plenty of drivers (like de4x5) that insist on using inw/outw
> > (and thus break on host bridge 2) but these drivers should be
> > fixed.
>
> Is there still a need for de4x5? Since Jeff Garzik fixed the Tulip driver,
> that one works fine on PPC.

Yep, there's a little workaround for a buggy SROM on some embedded boards
in the de4x5 that I haven't yet moved to the tulip driver.  Of course,
it's written using I/O as well. :-/

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
