Subject: Re: PREEMPT on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <1080556990.2441.118.camel@thor.asgaard.local>
References: <1080197240.1210.2.camel@gaston>
	 <1080201697.1217.3.camel@gaston>
	 <1080399924.2514.14.camel@thor.asgaard.local>
	 <1080523601.1209.46.camel@gaston>
	 <1080524303.2441.108.camel@thor.asgaard.local>
	 <1080525344.1209.53.camel@gaston>
	 <1080556990.2441.118.camel@thor.asgaard.local>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1080561617.1385.21.camel@gaston>
Mime-Version: 1.0
Date: Mon, 29 Mar 2004 22:00:18 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-03-29 at 20:43, Michel Dänzer wrote:
> On Mon, 2004-03-29 at 03:55, Benjamin Herrenschmidt wrote:
> > > Note that I'm not sure how tightly the problems are tied to swap; after
> > > they start, they seem to persist even when swap is no longer used. It's
> > > just the best criterion I've been able to identify so far.
> >
> > Weird. I just can't reproduce any of your problems, neither on the
> > tipb with highmem & lots of RAM, or on the wallstreet with no highmem
> > and little RAM (thus swap)...
> >
> > I've been running with preempt for a few days now without trouble.
> >
> > What else are you using ? I suspect something like MOL may have troubles
> > with preempt for example...
>
> Not using that regularly. Not sure what's special about my setup, XFS
> maybe?
>
> What about this:
>
> -CONFIG_TASK_SIZE=0xc0000000
> +CONFIG_TASK_SIZE=0x80000000
>
> I can't seem to find any other significant differences between
> pmac_defconfig and mine. I'll keep trying...

Shouldn't affect it, on ppc32, I hope nothing tries to map between 2G
and 3G... (except on G5 though)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
