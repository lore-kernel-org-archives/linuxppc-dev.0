Message-ID: <3B4B30AF.B925F6A0@mvista.com>
Date: Tue, 10 Jul 2001 09:43:27 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Torben Mathiasen <torben@kernel.dk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RTC drift on Walnut?
References: <20010707220903.A1199@fry> <3B4971C3.2ADEAF79@mvista.com> <20010709181719.A798@fry>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Torben Mathiasen wrote:

> Thanks. I'm pretty sure its kernel related, I bet something's wrong in
> arch/ppc/kernel/time.c. The kernel just reads the RTC at startup, and maintains
> the system clok via the timer-interrupts. Coming to think of it, I'm not sure
> if the hardware RTC drifts, or if its just the kernel 'software' clock. Will
> check on that.
>
> Maybe we're turning ints off for too long somewhere...
>
> Thanks,
> Torben


Torben;

I am running on what will be the next version of 405 kernel from
MontaVista.  It is using the new todc_time routines.  I saw about a 30
second drift.

-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
