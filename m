To: Dan Malek <dan@netx4.com>
Cc: Seungdong Lee <sdlee@da-san.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8240 BogoMIPS
References: <39263EA0.69C60AA9@da-san.com> <3926CD15.441C87AB@embeddededge.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 20 May 2000 22:14:39 +0200
In-Reply-To: Dan Malek's message of "Sat, 20 May 2000 13:36:21 -0400"
Message-ID: <vehfbtasi8.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> Seungdong Lee wrote:
> > BogoMIPS value of my board is currently 131.89.
> > My board is configured to run in 200MHz system clock.
>
> I have not booted my 8240 for a while, and I don't remember the number.
> I have another 8240 showing up soon, so I will be back on that before
> long and will pay attention to this.  For some reason, I do remember that
> with caches disabled this number is _really_ small, like 13 or 18 or
> something.

I'm not very familiar with 82x0 processors, but doesn't 8240 use a
603-core? When I worked with a 603ev running at 200 MHz I got
something like 133 BogoMIPS, so then the above value would be correct.

> I wouldn't use BogoMIPS for any kind of benchmark.  There have been
> plenty of discussions on mailing lists (including linuxppc lists) to
> indicate this abosolute number doesn't mean much.  I have many PowerPC
> systems running Linux, from 8xx embedded though 7400/G4 systems.  I
> certainly can't predict what this number "should" be.

The BogoMIPS can be used for rough sanity-checks when comparing
processors with identical cores and different clocks. For anything
else it's completely useless. And excelent example is that a
Pentium CPU gives a BogoMIPS value of about 1xclock, while a Pentium
MMX CPU gives about 2xclock, even though their real-life performance
is practicly the same.

//Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
