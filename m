Subject: Re: PREEMPT problems
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Colin LEROY <colin@colino.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1081212676.1426.166.camel@gaston>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
	 <1080867387.1203.19.camel@gaston>
	 <1080921611.11826.13.camel@thor.asgaard.local>
	 <1080924194.11826.27.camel@thor.asgaard.local>
	 <1080961566.1425.84.camel@gaston>
	 <1080997005.4208.24.camel@thor.asgaard.local>
	 <1081212676.1426.166.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1081294118.2722.43.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Wed, 07 Apr 2004 01:28:39 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-04-06 at 02:51, Benjamin Herrenschmidt wrote:
> > Sure enough, -rc2-ben0 is now behaving just as badly as -rc3-ben0.
> > Probably just fluctuation.
> >
> > > I also added a WARN_ON(), do you see it triggered in dmesg ?
>
> Still can't reproduce any problem here. You are using xfs right ?

Yes. Colin, what about you?

> Maybe it's a filesystem issue... or some driver (USB device ?)

The only USB device I'm using regularly is a mouse.

> that you are using that is allergic to preempt ?

I don't think I'm using anything exotic... do you think ALSA could cause
such problems? The filesystem seems more likely to me, but what do I
know.


> It would be useful if you could spot one of those stuck processes
> and get a backtrace from it. For that, use P<pid> in xmon to get the
> ksp then b<ksp value> to get a backtrace.

I'm back to a non-preempt kernel for the time being, but I'll try to do
that if I ever feel adventurous again, and provided I find out how to
get into xmon.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
