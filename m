Message-ID: <3AB0BECF.650FA111@inn.ericsson.se>
Date: Thu, 15 Mar 2001 14:08:31 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: walnut 405
References: <3AAF73C0.D0DA94A6@inn.ericsson.se> <3AAFC805.AE1CA2B@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Rowand wrote:
>
> Kenneth Johansson wrote:
> >
 > Things looks quite good I now have a debian potato for ppc running on the card
> > but there is a few problems.
> >
> > 1. It kills the Ethernet port on a cisco catalyst 5505 switch/router.
>
> Can you get a network trace to see what packets are involved?

Yes I can snoop it with tcpdump but it has to wait until next week. This will only
show something if the content of the packet is wrong but I think the problem is more
timing related but that is only a guess.

>
> > 2. it's not possible to run gdb
>
> Yes, ptrace is still not yet implemented for the 4xx.  This means that both gdb

That explains it :)

> robust version in place.  I hope to have this available very soon.  (If anyone
> feels like debugging this, I can send them my current patch.)

I can test it but don't have much time to actually debug this right now. Once this works
it should be simpler to find out what the kernel dose when running emacs that prevents dpkg
to run after it.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
