Message-Id: <200007082206.XAA15459@hyperion.valhalla.net>
Date: Sat, 08 Jul 2000 23:06:40 +0100
Subject: Re: X still locks up
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Gwyn Judd <b.judd@xtra.co.nz>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sat, Jul 8, 2000  Gwyn Judd wrote:
> On Fri, Jul 07, 2000 at 12:53:32PM +0200, Benjamin Herrenschmidt wrote:
[...]
>>
>> Can you give a try to my current rsync tree (linuxcare.com.au::linux-
>> pmac-benh) and tell me if it helps ?
>
> Okay I got that kernel working but it crashed overnight :(. Seems like
> the problem is still there. It seems to happen most often when I'm
> listening to streaming mp3's (ie. internet radio stations or the like)
> if that helps.

Three things:

1/ did you try the backported audio stuff I posted yesterday - there were
some issues that were resolved between 2.2.xx and 2.3/4.xx these should be
present in the backport.  It does work OK against 2.2.17pre10-ben1.

2/ You could try separating out audio, X, & network-related fault areas by
running each area separately for a while?

3/ It tends to look (as Michel said yesterday) potentially like a hardware
problem.  I assume you have no over-clocking or stuff like that going on?
(unlikely on PPC I agree but I thought I'd ask).

BTW I've never had a random lock-up on Xpmac...

good luck,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
