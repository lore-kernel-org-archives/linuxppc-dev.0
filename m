Date: Sat, 25 Aug 2001 15:54:17 -0700
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc 2.1 -> 2.2 gotchas?
Message-ID: <20010825155417.A8892@nevyn.them.org>
References: <998751333.12597.3.camel@yoda> <01082511424509.15847@localhost.localdomain> <20010826005515.Postino-022357@smtp01.highway.ne.jp> <01082513443402.16172@localhost.localdomain> <3B882749.346A0B39@iiic.ethz.ch> <20010825154233.S14302@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010825154233.S14302@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Sat, Aug 25, 2001 at 03:42:33PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 25, 2001 at 03:42:33PM -0700, Tom Rini wrote:
>
> On Sun, Aug 26, 2001 at 12:31:37AM +0200, Michel D?nzer wrote:
>
> > > What I recommend won't hurt and can certainly help flush older shared
> > > libraries out of memory.
> >
> > The point is probably that in the Debian packages, the maintainer scripts take
> > care of the necessary steps, so the user doesn't have to.
>
> This always got me tho...  If a program is already running, how do you
> make it stop using the old libraries?  If 'restarting' /sbin/init makes it
> reload, I'll take your word at it.  But what about all of the other apps that
> happen to be running?  The bash session I happen to be doing this upgrade
> from.  Or X (yes, in an ideal world, you goto single user to do this
> anyhow.. :))

They keep running with the old libc.  No big deal, really :)  The RAM
will basically not be reclaimed until after you reboot.

--
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
