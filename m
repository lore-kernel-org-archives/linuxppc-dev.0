Subject: Re: PREEMPT problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Colin LEROY <colin@colino.net>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1080997005.4208.24.camel@thor.asgaard.local>
References: <1b6001c417f6$229c2a70$3cc8a8c0@epro.dom>
	 <1080867387.1203.19.camel@gaston>
	 <1080921611.11826.13.camel@thor.asgaard.local>
	 <1080924194.11826.27.camel@thor.asgaard.local>
	 <1080961566.1425.84.camel@gaston>
	 <1080997005.4208.24.camel@thor.asgaard.local>
Content-Type: text/plain
Message-Id: <1081212676.1426.166.camel@gaston>
Mime-Version: 1.0
Date: Tue, 06 Apr 2004 10:51:18 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Sure enough, -rc2-ben0 is now behaving just as badly as -rc3-ben0.
> Probably just fluctuation.
>
> > I also added a WARN_ON(), do you see it triggered in dmesg ?

Still can't reproduce any problem here. You are using xfs right ?
Maybe it's a filesystem issue... or some driver (USB device ?) that
you are using that is allergic to preempt ?

It would be useful if you could spot one of those stuck processes
and get a backtrace from it. For that, use P<pid> in xmon to get the
ksp then b<ksp value> to get a backtrace.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
