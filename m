Date: Mon, 15 Feb 1999 10:25:07 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Troy Benjegerdes <hozer@drgw.net>, cort@cs.nmt.edu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <XFMail.990214190644.jeremy@goop.org>
Message-ID: <Pine.HPP.3.96.990215102358.5352d-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sun, 14 Feb 1999, Jeremy Fitzhardinge wrote:

> Thanks a lot - this should be very helpful.  BTW, how much work has been put
> into using Open Firmware callbacks rather than blowing OFW away (I guess that's
> more of a CHRP rather than PReP or MTX question)?

Not very much I think, and the boards I have with OF do not implement
RTAS, which makes blowing away OF the only viable solution.

	Gabriel.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
