Message-ID: <37CCC52B.BBD75BEA@cable.a2000.nl>
Date: Wed, 01 Sep 1999 08:18:19 +0200
From: Otto Moerbeek <otto@cable.a2000.nl>
MIME-Version: 1.0
To: Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP support for Daystar 604e 200MHz dual-processor card
 	>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras write:

> Martin Costabel <costabel@wanadoo.fr> wrote:
> 
> > (On the other hand, I see that Paul M. has CONFIG_SERIAL=m in his
> > standard config files. Does this mean that the serial.c stuff is
> > supposed to work on the PPC?)
> 
> Only with some awful hacks to disable the probing of I/O ports and to
> make it start at ttyS2 instead of ttyS0.  This hack is in my rsync
> trees and in the precompiled kernels I've done.  (I could post a patch
> if necessary.)
> 
> It's not a good long-term solution but I needed something so I could
> use the PC-card modem on my 3400. :-)
> 
> Paul.

I am happy to say that my patches to the standard serial driver which
were developed on LinuxPPC are in the latest 2.3 tree. Apart from making
it run on LinuxPCC, generic support for PCI cards was added, based on
work from various programmers (including myself ;-) )

I have a version of the new serial driver that works on 2.2.10/LinuxPPC
available as standalone module, if anyone is interested.

Otto


-- 
Otto Moerbeek
otto@cable.a2000.nl

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
