Message-ID: <3AD48FE2.3FBE7B65@mvista.com>
Date: Wed, 11 Apr 2001 13:09:54 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: =?iso-8859-1?Q?S=E9bastien=20C=F4t=E9?= <scote1@matrox.com>
Cc: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: frequency in sandpoint_calibrate_decr
References: <3AD4722B.3B22120@matrox.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sébastien Côté wrote:

> In MontaVista's kernel 2.4.0-test2, the frequency in
> sandpoint_calibrate_decr() is set to 66 Mhz.  What frequency is this?
> The processor, the bus ???

That's the speed of the processor bus, usually from which all
other core clocks are derived.  You should be using a newer version
of the kernel, at least from FSM Labs BitKeeper.  In the source
code pipeline is a change of the clock value from MHz to Hz.

> Increasing this speed seems to get rid of my stability problems (at
> last!), so I'd like to know the real value I should put there.

Eh?  On most systems it won't do anything but affect the ability
of the kernel to keep time correctly.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
