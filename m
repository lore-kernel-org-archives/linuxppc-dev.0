Message-ID: <3922EE48.1E41DA1B@motorola.com>
Date: Wed, 17 May 2000 14:08:56 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: "Dan A. Dickey" <ddickey@charter.net>
CC: Nicolas-Peter Pohland <pohland@snom.de>,
        "linuxppc-embedded@lists.linuxppc.org"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net> <3920AA9F.2DCA0B2E@charter.net> <3920ED16.A2D26629@snom.de> <3921B844.572E3C63@charter.net> <3922046E.D77E156@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan A. Dickey" wrote:
>
> "Dan A. Dickey" wrote:
> >
> > Nicolas-Peter Pohland wrote:
> > >
> > > Did you try "rms der 0" (assuming you have the ADI board and MPC8bug SW)
> >
> > Nope, haven't tried that.  I'll look at it later tonight; thanks
> > for the tip.
>
> Good!  Fantastic tip.
> This helps tremendously, especially in the fact that now I can
> actually boot and run the kernel on my fads... while the ADI &
> mpc8bug are connected.  Before that, I would always get the
> InstructionTLBMiss exception - and of course, mpc8bug didn't
> really know anything about the address.
>
> Also, I'm also now running in "stand alone" mode - with the
> ADI & mpc8bug disconnected.  Straight from the flash.
>
> For me, this is great news.  I know that most of you don't
> give a hoot!  :)

Au Contraire, I care very much, being the MPC823 support body! :)

> So, I'm attributing this recent success to:
>         A)  Setting SYPCR in the rom code fairly early on.
>         B)  Issuing a "rms der 0" to mpc8bug when it is connected.

Interesting.  So clearing the SYPCR early in the ROM code is what
was preventing you from getting the code to run stand-alone?  Kinda
odd, considering the initial value of the watchdog is very long,
and you were having problems getting your Aux LED to turn on
right at the very beginning.

> I'm a happy camper at the moment.  Mostly.  :)
> I just need to get my regular system setup to allow bootp and
> host an nfs root for the fads.
> Also, I just noticed - the kernel couldn't mount root, so it's
> doing its "Rebooting in 180 seconds.." act.  However, about
> all I'm seeing after that is a:
>         <0>Kernel panic: Kernel Mode Software FPU Emulation
> and then the duo is repeating every 180 seconds...
> Not quite what I call a reboot.  I would think it would at
> least manage to restart the rom initialization code.
> Anyways, thats relatively minor...
> have a good night!
>         -Dan
>

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
