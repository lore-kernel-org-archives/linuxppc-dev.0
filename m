Message-ID: <D73A25AA6E54D511AD74009027B1110F2C852E@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Magnus Damm'" <damm@opensource.se>, John.Fisher@nec.com.au
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cygwin and embedded linux
Date: Wed, 21 Aug 2002 11:07:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


viosoft has done it

-----Original Message-----
From: Magnus Damm [mailto:damm@opensource.se]
Sent: Wednesday, August 21, 2002 10:54 AM
To: John.Fisher@nec.com.au
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cygwin and embedded linux



> Is anyone seriously trying to do embedded Linux development for power PC
> using Cygwin as the host?

I've designed a build-system for a customer, and I tried (just to see
how
much that worked ok) to build under Cygwin. Everything worked out ok
until
the system cross compiled glibc-2.1.3. Building glibc generated a error
message that meant something like you-have-bad-memory-on-your-system.
I tried to find the source of the problem with rebuilding and running
memtest86. But no success. But this was maybe a year ago.

The same system works great on Linux boxes.

That's my only experience.

But I have a box from Lynuxworks somewhere here (someone gave it to me)
and that box says that the build system is hosted on windows...

/ Magnus

John Fisher wrote:
>
> Is anyone seriously trying to do embedded Linux development for power PC
> using Cygwin as the host?
>
> I'm trying to get linux running on proprietary MPC850/860/8260 boards.
I'll
> start with either the 850 or the 860 board as I'm more familiar with these
> processors than with the 8260.
>
> I have the Macraigor blackbird BDM interface for the MPC850/860. I have
both
> an Agilent ethernet based probe and the Wind River Vision Probe II for the
> 8260.
>
> All boards will be running with plenty of flash and RAM: 16MB and 32MB
> respectively for both the 850 and 860 boards. They will be running with no
> disk drive, no monitor and a serial port on SCC3.
>
> I may have real time requirements, but this is yet to be determined.
>
> This is a learning exercise at this stage.
>
> John Fisher
> NEC Australia Pty Ltd
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
