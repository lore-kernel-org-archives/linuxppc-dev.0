Message-ID: <39289DA5.F0A5B8FF@da-san.com>
Date: Mon, 22 May 2000 11:38:29 +0900
From: Seungdong Lee <sdlee@da-san.com>
MIME-Version: 1.0
To: Marcus Sundberg <marcus@cendio.se>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8240 BogoMIPS
References: <39263EA0.69C60AA9@da-san.com> <3926CD15.441C87AB@embeddededge.com> <vehfbtasi8.fsf@lipta.cendio.se>
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> Dan Malek <dan@netx4.com> writes:
>
> > Seungdong Lee wrote:
> > > BogoMIPS value of my board is currently 131.89.
> > > My board is configured to run in 200MHz system clock.
> >
> > I have not booted my 8240 for a while, and I don't remember the number.
> > I have another 8240 showing up soon, so I will be back on that before
> > long and will pay attention to this.  For some reason, I do remember that
> > with caches disabled this number is _really_ small, like 13 or 18 or
> > something.
>
> I'm not very familiar with 82x0 processors, but doesn't 8240 use a
> 603-core? When I worked with a 603ev running at 200 MHz I got
> something like 133 BogoMIPS, so then the above value would be correct.
>

Good information.
But, why it is 133 BogoMIPS?
I still think that the correct value is 400.

>
> > I wouldn't use BogoMIPS for any kind of benchmark.  There have been
> > plenty of discussions on mailing lists (including linuxppc lists) to
> > indicate this abosolute number doesn't mean much.  I have many PowerPC
> > systems running Linux, from 8xx embedded though 7400/G4 systems.  I
> > certainly can't predict what this number "should" be.
>
> The BogoMIPS can be used for rough sanity-checks when comparing
> processors with identical cores and different clocks. For anything
> else it's completely useless. And excelent example is that a
> Pentium CPU gives a BogoMIPS value of about 1xclock, while a Pentium
> MMX CPU gives about 2xclock, even though their real-life performance
> is practicly the same.
>

Maybe it is because of the difference in superscalar architecture.

-- Seungdong Lee

>
> //Marcus
> --
> -------------------------------+-----------------------------------
>         Marcus Sundberg        |       Phone: +46 707 452062
>   Embedded Systems Consultant  |      Email: marcus@cendio.se
>        Cendio Systems AB       |       http://www.cendio.com
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
