Subject: Re: PREEMPT on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <1080524303.2441.108.camel@thor.asgaard.local>
References: <1080197240.1210.2.camel@gaston>
	 <1080201697.1217.3.camel@gaston>
	 <1080399924.2514.14.camel@thor.asgaard.local>
	 <1080523601.1209.46.camel@gaston>
	 <1080524303.2441.108.camel@thor.asgaard.local>
Content-Type: text/plain
Message-Id: <1080525344.1209.53.camel@gaston>
Mime-Version: 1.0
Date: Mon, 29 Mar 2004 11:55:45 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Note that I'm not sure how tightly the problems are tied to swap; after
> they start, they seem to persist even when swap is no longer used. It's
> just the best criterion I've been able to identify so far.

Weird. I just can't reproduce any of your problems, neither on the
tipb with highmem & lots of RAM, or on the wallstreet with no highmem
and little RAM (thus swap)...

I've been running with preempt for a few days now without trouble.

What else are you using ? I suspect something like MOL may have troubles
with preempt for example...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
