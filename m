Message-ID: <38188496.DF592083@snom.de>
Date: Thu, 28 Oct 1999 19:15:02 +0200
From: Nicolas Pohland <pohland@snom.de>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8BUG crashes on Windows 95/98/NT
References: <381706D7.FF1D8477@snom.de> <38171E45.DC552AAF@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> 
> Go into the e-mail archives and read my past messages.  It has
> helped some people.....and pissed off others.....

Essentially the email lists imply to chuck the FADS. Is this a correct
summary ?

I downloaded mpc8bug version 1.5 from
http://www.motorola.com/SPS/ADC/pps/subpgs/etoolbox/8XX/MPC8bug.html 
after getting tipped off and this worked under NT 4.0 SP 5 when merging
this with the 1.6 configuration files of mpc8bug.

HINTS
-----

ELF files sre supported by LOADF but only after specifying -Ttext to
0x2800000.

The first parameter for mpc8bug is not the base address of the ADI board
divided by 0x100. Instead it is the index into the
device list (normally 0).


I will now continue to debug the image unless a tarball with a FADS 860T
floats along :-). I will be happy to provide one
once I am finished.

Nicolas

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
