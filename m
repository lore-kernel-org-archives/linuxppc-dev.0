Message-ID: <XFMail.990214190644.jeremy@goop.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.04.9902132334480.4390-100000@narn.local.drgw.net>
Date: Sun, 14 Feb 1999 19:06:44 -0800 (PST)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Troy Benjegerdes <hozer@drgw.net>
Subject: Re: Interrupt routing in prep_pci.c
Cc: cort@cs.nmt.edu, linuxppc-dev@lists.linuxppc.org,
        Gabriel Paubert <paubert@iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 14-Feb-99 Troy Benjegerdes wrote:
> You may also find my patches for MTX SMP support usefull. It contains most
> of the stuff in Geert's patches, with the addition that most all of the
> architecture-dependent functions have been redone to be dispatched by a
> structure of function pointers. (Thanks to Corey Minyard) This gets rid of
> a great number of case statements, and what could be the framework for a
> good cleaning up of the arch/ppc/kernel directory. I suspect it might make
> porting to a yellowknife like board easier. If the yellowknife board
> supports SMP and has an OpenPIC, my SMP patches might work also ;)

Thanks a lot - this should be very helpful.  BTW, how much work has been put
into using Open Firmware callbacks rather than blowing OFW away (I guess that's
more of a CHRP rather than PReP or MTX question)?

        J

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
