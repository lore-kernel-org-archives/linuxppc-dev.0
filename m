To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 20 Mar 2002 10:58:01 EST."
             <3C98B189.78A92DFE@mvista.com>
Date: Wed, 20 Mar 2002 19:12:46 +0100
Message-Id: <20020320181251.C61EF109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3C98B189.78A92DFE@mvista.com> you wrote:
>
> I think this is a result of a fundamental difference in views of how much
> work should be put into 2.4 bi_rec's.

Probably.

> a) Do it the same was as we're going to do it in 2.5
> pros:
> -----
> - 2.4 & 2.5 are consistent
> cons:
> -----
> - we don't know what we're doing in 2.5 yet and probably won't for some time
> - its more kernel/driver work in the short term for 2.4
>
> b) Do a more advanced bi_rec scheme (like benh's proposal)
> pros:
> -----
> - more general/flexible than c) below
> - may be less work than a) above (depends on what 2.5 does)
> cons:
> -----
> - a 2.4 solution only (unless its ends up being what 2.5 uses too)
> - more kernel work in short term than c)
>
> c) Do mininimum necessary in 2.4; do it "right" in 2.5
> pros:
> -----
> - minimal up front kernel work in 2.4
> - can get it done "now"
> cons:
> -----
> - a 2.4 solution only
> - less general solution

I've deleted the ppcboot entries from that list; PPCBoot is just  one
of  many boot loaders, and doesn;t need any special handling. We will
adapt with what we have to - one way or another.

> Although the list I provided assumed that c) was the path, I personally have
> no opinion on this.  I just want us to all agree on which path then bang out
> the details.

So how do we come to the agreement? By voting? My vote is b),  hoping
that the result will be good enough to be accepted for 2.5, too.

> Can we focus on this question so we can stop going in circles?  Besides if we

I stop going in cricles here (for this round).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"How is this place run - is it an anarchy?"
"No, I wouldn't say so; it is not that well organised..."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
