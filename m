Message-Id: <199906301644.LAA32319@www2.tuckeris.com>
Date: Wed, 30 Jun 1999 11:32:50 -0500
Subject: Re: LinuxPPC R5 on PowerBook Series 1999
From: "Charles A. Jolley" <charles.jolley@zeratec.com>
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



----------
>From: Benjamin Herrenschmidt <bh40@calva.net>
>Date: Wed, Jun 30, 1999, 11:11 AM
>
>
> Did you try with the "no video driver" option ?
>

In fact, I tried it with both "no video driver" option checked and
unchecked.

> This may also be a backlight problem, Apple love changing the way the
> backlight is controlled from one model to the other. You can try
> commenting out the backlight control functions in drivers/macintosh/via-pmu.c.

Ah-ha...this would make sense...it is consistent with the behavior I'm
seeing.  I need to get R5 setup on my other machine here before I can
recompile the kernel without the backlight functions and try it again so it
may be a week or so before I can do this...maybe I can try it this
weekend...

-Charles

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
