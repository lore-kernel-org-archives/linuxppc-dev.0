Date: Mon, 15 Feb 1999 10:23:28 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Jeremy Fitzhardinge <jeremy@goop.org>, linuxppc-dev@lists.linuxppc.org,
        cort@cs.nmt.edu
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <Pine.LNX.4.04.9902132334480.4390-100000@narn.local.drgw.net>
Message-ID: <Pine.HPP.3.96.990215102202.5352c-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sat, 13 Feb 1999, Troy Benjegerdes wrote:

> You may also find my patches for MTX SMP support usefull. It contains most
> of the stuff in Geert's patches, with the addition that most all of the
> architecture-dependent functions have been redone to be dispatched by a
> structure of function pointers. (Thanks to Corey Minyard) This gets rid of
> a great number of case statements, and what could be the framework for a
> good cleaning up of the arch/ppc/kernel directory. I suspect it might make
> porting to a yellowknife like board easier. If the yellowknife board
> supports SMP and has an OpenPIC, my SMP patches might work also ;)

I forgot to tell that my patch includes all of the preceding plus some
updates to the prepboot code.

	Gabriel. 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
