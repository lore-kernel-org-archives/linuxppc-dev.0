Subject: Re: Weird interrupt problem
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020808120700.30639@192.168.4.1>
References: <1028761518.1262.1236.camel@tibook>
	<20020808120700.30639@192.168.4.1>
Content-Type: text/plain; charset=ISO-8859-1
Date: 16 Aug 2002 19:01:23 +0200
Message-Id: <1029517283.26309.2560.camel@pooky>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2002-08-08 at 14:07, Benjamin Herrenschmidt wrote:
>
> >Today this happened to me the second time: All of a sudden, the USB
> >mouse stopped working. At the same time this appeared in the syslog:
> >
> >Aug  7 17:19:57 tibook kernel: Unhandled interrupt 1d, disabled
> >
> >Plugging the mouse to the other socket worked, but it wouldn't work
> >again in the original one. As you can see in the attached
> >/proc/interrupts, interrupt 29 (=1d) is unknown. Interestingly,
> >interrupt 28 seems to be for the USB socket which stopped working (I
> >think it was the same one when the first problem first occured, might be
> >coincidence though). Was it somehow rewarded for its 100'000th
> >occurence? ;) Seriously, is it possible that the number changed somehow?
> >
> >
> >This wouldn't be all that bad, if the whole system wasn't very sluggish
> >afterwards. When it occured the first time, I had CONFIG_TAU enabled in
> >the kernel, which Ben said might cause the sluggishness at least. But
> >now it's disabled.
> >
> >
> >This is on a TiBook III/667 running 2.4.18-ben0-lotsanicestuff if it
> >matters. The first occurence was with 2.4.19-presomething-ben0.
> >
> >
> >Has anyone experienced anything similar?
>
> Really weird. It looks like the openpic is going south. Seriously, looks
> like a HW problem, that is the interrupt controller starts giving us
> bogus interrupt numbers. Doesn't sound good at all :(

Well, now the machine is off to Apple to repair PMU problems. Maybe this
was a kind of an early warning sign.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
