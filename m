To: Seungdong Lee <sdlee@da-san.com>
Cc: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8240 BogoMIPS
References: <39263EA0.69C60AA9@da-san.com> <3926CD15.441C87AB@embeddededge.com> <vehfbtasi8.fsf@lipta.cendio.se> <39289DA5.F0A5B8FF@da-san.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 22 May 2000 11:34:57 +0200
In-Reply-To: Seungdong Lee's message of "Mon, 22 May 2000 11:38:29 +0900"
Message-ID: <vevh07dj26.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Seungdong Lee <sdlee@da-san.com> writes:

> Marcus Sundberg wrote:
> > I'm not very familiar with 82x0 processors, but doesn't 8240 use a
> > 603-core? When I worked with a 603ev running at 200 MHz I got
> > something like 133 BogoMIPS, so then the above value would be correct.
> >
>
> Good information.
> But, why it is 133 BogoMIPS?

Because that's what a 200 MHz PowerPC 603 gives you.
Checking the BogoMIPS howto will show you one report of a 603,
running at 100 MHz and giving 66 BogoMIPS, which is at par with
our results.

> I still think that the correct value is 400.

Unless you have tried other 603-based sytems you have no reason to
think so. I repeat my statement from the previous post:

> > The BogoMIPS can be used for rough sanity-checks when comparing
> > processors with identical cores and different clocks. For anything
> > else it's completely useless.

//Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
