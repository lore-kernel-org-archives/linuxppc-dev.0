In-Reply-To: <l03130301b2e69f7f1da5@[209.251.79.177]>
Date: Wed, 10 Feb 1999 12:49:19 +0100
To: "Michael R. Zucca" <mrz5149@acm.org>, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: NuBus PowerMacs and PDM video
Message-Id: <19990210124919.012660@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 9, 1999, Michael R. Zucca <mrz5149@acm.org> wrote:

>You just need to know the physical base address of the frame buffer.
>Once you know that you can just rewrite the page tables to put the
>frame buffer anywhere you'd like it.

I was thinking about the machines that store the framebuffer in main
memory (I beleive the 6100 does this). In this case, several people told
me that the physical address was actually 0. Anyway, I now have some code
to mess with the video controller, so I will be able to work around this
problem.

>You need to write a program under MacOS that will find a physical address
>for a given virtual address. You'll probably need to do this in assembly
>or there may even be a toolbox call that will do this for you.

There is a MacOS call for logical->physical mappings. The base address
sent by BootX to the kernel is already a physical address (actually both
are sent with BootX >= 1.0.2b1)


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
