Message-ID: <3A5B83C4.3A73B434@mvista.com>
Date: Tue, 09 Jan 2001 16:33:56 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
CC: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: es1371 on the 405gp and Monta Vista Kernel
References: <3A5B159E.E8B95DC7@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
> I am trying to port the es1371 device driver to the MontaVista kernel on
> the IBM 405gp.
> The driver, with no modicifiction, seems to play voice in slow motion.

When you 'cat /dev/sndstat', what does it think the sampling rate is
and does that match what you set?  For that matter, what program
did you use to play the sound and did it try to set the proper
sampling rate?

If the /dev/sndstat has the proper sampling rate, check to make sure
the 'outl' macro is doing the proper byte swapping when setting the
control registers on the src_write() function.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
