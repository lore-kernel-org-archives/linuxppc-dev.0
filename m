Subject: Re: PREEMPT on PPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <1080201697.1217.3.camel@gaston>
References: <1080197240.1210.2.camel@gaston>
	 <1080201697.1217.3.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1080399924.2514.14.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Sat, 27 Mar 2004 16:05:24 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-03-25 at 09:01, Benjamin Herrenschmidt wrote:
> On Thu, 2004-03-25 at 17:47, Benjamin Herrenschmidt wrote:
> >
> > I've start looking into the various issues of running CONFIG_PREEMPT
> > on ppc32. I found some problems, there may be more, but here's a first
> > patch that should apply on a recent 2.6.x.
> >
> > I suggest if you want to try this out that you run with the various
> > kernel debugging options enabled. Report me remaining problems.
>
> And here's an updated version of that patch that doesn't break
> sleep on laptops.

I appreciate a lot that you're working on this, but unfortunately, this
patch doesn't seem to make any difference here. I still get random
segfaults, weird behaviour in galeon, ... as soon as I hit swap. How can
I provide useful debugging information?


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
