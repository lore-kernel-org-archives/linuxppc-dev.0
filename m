Date: Mon, 9 Jul 2001 18:17:20 +0200
From: Torben Mathiasen <torben@kernel.dk>
To: akuster@mvista.com
Cc: Torben Mathiasen <torben@kernel.dk>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: RTC drift on Walnut?
Message-ID: <20010709181719.A798@fry>
References: <20010707220903.A1199@fry> <3B4971C3.2ADEAF79@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B4971C3.2ADEAF79@mvista.com>; from akuster@mvista.com on Mon, Jul 09, 2001 at 01:56:35AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


tn Mon, Jul 09 2001, akuster@mvista.com wrote:
> Torben Mathiasen wrote:
> >
> > Hi,
> >
> > I'm seeing a rather large drift of the RTC on a Walnut system. I haven't
> > got the exact numbers, but its something like 20mins in 24 hours.
> > This is with the montavista 2.4.2 kernel.
> >
> > Has anyone seen this before?
> >
> > Thanks in advance,
> >
> > Torben
> >
>
> Torben;
>
> I am not sure.  I will have to check, I will let you know tomorrow.

Thanks. I'm pretty sure its kernel related, I bet something's wrong in
arch/ppc/kernel/time.c. The kernel just reads the RTC at startup, and maintains
the system clok via the timer-interrupts. Coming to think of it, I'm not sure
if the hardware RTC drifts, or if its just the kernel 'software' clock. Will
check on that.

Maybe we're turning ints off for too long somewhere...

Thanks,
Torben

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
