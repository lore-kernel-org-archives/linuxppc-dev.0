Mime-Version: 1.0
Message-Id: <p06001802bb31ce9d661c@[192.168.9.138]>
In-Reply-To: <DAD09CD5-B1C0-11D7-8101-003065F22EAA@mindspring.com>
References: <DAD09CD5-B1C0-11D7-8101-003065F22EAA@mindspring.com>
Date: Wed, 9 Jul 2003 10:22:35 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: OT: wanting to write PCI daemon
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>You may be aware of this already, but it seems like an obvious question
>to ask, so: Are your cards 5V, or are they Universal (compatible with
>both 5V and 3.3V)?  If they're Universal, they will work as-is.  The
>conflict isn't about PCI protocol vs PCI-X protocol (PCI-X is backwards
>compatible), it's about signal levels.

Correct. Our cards are 5V only :-/

>>  But to further our next-gen design,
>>we'd like to go ahead and run a linux kernel on it. That means it
>>will likely be Intel, so already I'm getting seriously close to
>>getting booted here, but this we know how to do.
>
>Aw, c'mon, use one of those cute little TeronCX boards or something
>like that.  :)

Overkill on the PCI :-) We need one slot

Actually, we were looking at something like the following concept(s):

<http://www.mini-itx.com/hardware/intro.asp>
<http://www.hushtechnologies.net/hushmini.htm>
<http://www.michael-dieckmann.de/projekt_luefterlose_pc.htm>


>My only comment here is that the phrase "PCI daemon" probably isn't the
>way you should think of it.

ya, I figured that. Thanks for the other comments.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
