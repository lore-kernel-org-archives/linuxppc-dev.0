Message-ID: <3AF72947.AF40E2C8@mvista.com>
Date: Mon, 07 May 2001 19:01:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Eli Chen <eli@routefree.com>
Cc: brian.kuschak@skystream.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <027b01c0d728$9a702b80$4b00000a@foolio1> <3AF710DC.37209810@mvista.com> <032e01c0d73f$58022160$4b00000a@foolio1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Chen wrote:

> I have also occasionaly received other messages, which I have yet to receive
> after changing atomic.h.

I dunno..........The code can't be broken because it is used
everyday on bazillions of processors.....I can't believe these
instructions are "broken" on the 4xx because that would be too
obvious as well.  I suspect all you are doing is changing some
code timing and masking the real problem.  I'm not saying we
shouldn't fix it, just that it isn't likely the problem is here.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
