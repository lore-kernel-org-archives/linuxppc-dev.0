Subject: Re: PREEMPT on PPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <1080523601.1209.46.camel@gaston>
References: <1080197240.1210.2.camel@gaston>
	 <1080201697.1217.3.camel@gaston>
	 <1080399924.2514.14.camel@thor.asgaard.local>
	 <1080523601.1209.46.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1080524303.2441.108.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Mon, 29 Mar 2004 03:38:24 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-03-29 at 03:26, Benjamin Herrenschmidt wrote:
> > I appreciate a lot that you're working on this, but unfortunately, this
> > patch doesn't seem to make any difference here. I still get random
> > segfaults, weird behaviour in galeon, ... as soon as I hit swap. How can
> > I provide useful debugging information?
>
> In general, is there a relationship with highmem ? that is do you
> have highmem enabled and if yes, does it get better without it ?

It's enabled, but diasbling it didn't seem to make a difference either.

FWIW, http://penguinppc.org/~daenzer/config-2.6.5-rc2-ben0-ck1 is my
current, preempt-less config.

Note that I'm not sure how tightly the problems are tied to swap; after
they start, they seem to persist even when swap is no longer used. It's
just the best criterion I've been able to identify so far.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
