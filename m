From: Frodo Looijaard <frodol@dds.nl>
Message-Id: <199904281409.QAA01267@arda.frodo.local>
Subject: Re: Support for Hydra i2c
To: Geert.Uytterhoeven@cs.kuleuven.ac.be (Geert Uytterhoeven)
Date: Wed, 28 Apr 1999 16:09:05 +0200 (CEST)
Cc: lm78@stimpy.netroedge.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.9904281104050.12292-300000@mercator.cs.kuleuven.ac.be> from "Geert Uytterhoeven" at Apr 28, 99 11:20:36 am
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> 
> The attached patch adds support for the i2c interface on the Apple `Hydra' Mac
> I/O, found on CHRP PPC motherboards. The patch is relative to the anon CVS
> version of yesterday evening.

Congratulations! You are the first to add support for a non-Intel 
architecture. I am very excited by your contribution! To be honest, I did
not even know the PPC architecture had an I2C interface. Very nice indeed!

I will merge your code in later today, and if necessary I will send you some
feedback on it. You may want CVS write access; it will make maintaining 
everything a lot easier for all of us. Phil is the one who needs to make 
an account for you; he also manages the mailing list, which might be 
interesting to you too. Phil, can you contact Geert for this?
 
>   - prog/dump/isadump.c
> 
>       o glibc 2.1 doesn't have <sys/perm.h>
>       o make it compile on PPC (ISA I/O is memory mapped, but it doesn't work
> 	anyway because different types of PPC boxes have ISA I/O space at
> 	different addresses :-(
>       o fix a typo (datareg -> addrreg)

This was a very Intel-centered program :=). On Intel PCs, we often have
some hardware sensors attached to the ISA bus. We will have to find out
whether this is the case with PPCs too.
 
> The only things on my i2c bus are 2 SPD EEPROMS. I attached the output of the
> decode-dimms Perl script. It looks a bit weird though. 

Again, you need to talk to Phil. He wrote the EEPROM decode routines.

I am very curious whether anybody on the PPC has hardware monitoring sensors
attached. People, the sensors-detect script should work for you, but don't
try to do the ISA probing (you are asked whether you want it or not).

Good luck,
  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
  At my homepage you will also find a guide for installing glibc under Linux.
  New: Linux hardware monitoring kernel modules (LM78/79/80, Winbond etc.)
  

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
