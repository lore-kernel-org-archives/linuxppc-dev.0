Message-Id: <l03130301b2e804cd8aed@[209.251.79.61]>
In-Reply-To: <19990210124919.012660@mail.mipsys.com>
References: <l03130301b2e69f7f1da5@[209.251.79.177]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 10 Feb 1999 22:57:04 -0500
To: BenH <bh40@calva.net>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: NuBus PowerMacs and PDM video
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:49 AM -0500 2/10/99, BenH wrote:

>Anyway, I now have some code
>to mess with the video controller, so I will be able to work around this
>problem.

What does the code reveal about the controller? Is it the MkLinux code?

>There is a MacOS call for logical->physical mappings. The base address
>sent by BootX to the kernel is already a physical address (actually both
>are sent with BootX >= 1.0.2b1)

I could see why you're confused, then. The booter sends you an address of
zero and it looks like a bug. :) However, the fact that the frame
buffer starts at 0 physical is weird but shouldn't be an impediment.

The last time I heard of Apple doing this was on the IIsi/IIci. We've been
avoiding the subject in NetBSD-mac68k for some time now :)


_______________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
_______________________________________________________________________



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
