Message-Id: <200003281140.NAA05466@denx.local.net>
To: christof <xfr@freenet.de>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel executing from flash 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 Mar 2000 12:30:06 +0200."
             <38E089AD.F415DCB7@freenet.de>
Date: Tue, 28 Mar 2000 13:40:14 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <38E089AD.F415DCB7@freenet.de> you wrote:
>
> My primary aim is not to gain speed or to save money, although this is
> important for my application too.
> By fetching opcodes from flash I expect more stability in temperature- and
> emc-critical environement, for data in "ROM" is saver than in RAM. Of corse,
> there is always run-time critical data in RAM (processor stack), but the
> probability of "irrepairable" errors should decrease by runnig from flash.

A crash is a crash is a crash...

If you have memory errors, your system is bound to  crash  sooner  or
later, no matter if it hits the program code, or the stack, or data.

What's the difference between a crash because of a bad opcode or  one
because of a division by zero because of faulty data?

Black magic...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Work 8 hours, sleep 8 hours; but not the same 8 hours.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
