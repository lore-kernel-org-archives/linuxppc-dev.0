Message-ID: <3BAB1D7E.F408AF7C@raleigh.ibm.com>
Date: Fri, 21 Sep 2001 06:59:10 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linuxppc-dev@lists.linuxppc.org, mbs@mc.com
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <200109210528.f8L5SBb443059@saturn.cs.uml.edu> <3BAAD9DC.CE99A11@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan,

The 4xx has true little endian support.

Chip

Dan Malek wrote:
>
> "Albert D. Cahalan" wrote:
>
> > Quit spreading FUD. The 7450 has _better_ LE support than the 7400
> > and 7410 did.
>
> If you say so.....I grabbed my 740 manual, which seems to indicate
> only alignment errors caused alignment faults.  The 7540 actually
> lists instructions that entirely fault in LE mode.  Didn't seem
> like an improvement to me.  Sorry I didn't look at the 7400.....
> I guess I'll let the LE experts decide what to do since I don't
> know anything about it.
>
> Thanks.
>
>         -- Dan
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
