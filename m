Subject: Re: PREEMPT on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <1080399924.2514.14.camel@thor.asgaard.local>
References: <1080197240.1210.2.camel@gaston>
	 <1080201697.1217.3.camel@gaston>
	 <1080399924.2514.14.camel@thor.asgaard.local>
Content-Type: text/plain
Message-Id: <1080523601.1209.46.camel@gaston>
Mime-Version: 1.0
Date: Mon, 29 Mar 2004 11:26:41 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I appreciate a lot that you're working on this, but unfortunately, this
> patch doesn't seem to make any difference here. I still get random
> segfaults, weird behaviour in galeon, ... as soon as I hit swap. How can
> I provide useful debugging information?

In general, is there a relationship with highmem ? that is do you
have highmem enabled and if yes, does it get better without it ?

I hit swap on the test wallstreet here and things just worked...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
