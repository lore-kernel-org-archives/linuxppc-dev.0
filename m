Message-ID: <397366FA.73E9D6BD@mvista.com>
Date: Mon, 17 Jul 2000 13:05:14 -0700
From: Jun Sun <jsun@mvista.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: update: ppc IRQ blocking.
References: <200007161155.MAA19420@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> Hi,
>
> Well, much of the info presented in my message yesterday was bogus...
>
> The instrumentation needs improvement... it's missing too many cases where
> IRQs are switched on/off behind the back of the measurement (which is making
> it very difficult to narrow down the rogue...)
>
> I'm working on it.
>

I had a port to PPC that runs embedded planet RPX lite ???.  It ran
pretty OK.  Is this test done with my port or somebody else's port?  I
don't remember I released my port, although it is something on my todo
list ...


>
> P.S. Jun - do you want a copy of what I've got so far? or wait 'till it's
> done... I covered a lot more cases but still need to deal with all the stuff
> going on in head.S :-(

Sure.  I'd happy to take a look of it and perhaps integrate it into my
PPC port - if I ever get to do it.

Jun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
