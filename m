Message-Id: <200006230832.KAA17874@denx.local.net>
To: Patrick Lerda <Lerda@microprocess.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU problems? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Jun 2000 09:43:56 +0200."
             <17B78BDF120BD411B70100500422FC63079FA0@IIS000>
Date: Fri, 23 Jun 2000 10:32:10 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <17B78BDF120BD411B70100500422FC63079FA0@IIS000> you wrote:
>
> The things work better on our board now. The main problem, with 8xx kernel
> patches are spread everywhere, and kernel like mpc8xx contains
> a lot of useless changes that make the changes difficult to resync with the

Nobody forces you to apply patches you don't need or consider useless.

And I really don't understand what you're complaining about:  if  you
just  need  a stable, production quality 2.2.x Linux kernel then grab
the latest MontaVista version, configure, build and run.

Dan (and others) have pointed this out several times before.

If you need something more recent than 2.2.13 for  some  reasons  you
can  try  using  the  BetKeeper  tree  (2.4.0-test1-ac21 or so at the
moment). This is where current work is going into.

> serie. Kernel like 2.2.16 works properly and reliably on PPC7xx and PPC6xx
> processors,
> with a lot of PCI drivers functionnal now. I think the main effort will be
> to resync 8xx kernels
> with the standard ones. Now I have a patched 2.2.16 kernel that seems to
> work on our board. Complex operations like compiling a kernel

Porting those changes back to 2.2.xx with x > 13 seems just  a  waste
of time to me. You will throw all this away as soon as 2.4 is stable.

Is there any special reason you can't use the 2.2.3 MV sources?

Have you had a look at the 2.4.0-test* sources?

> take hours to complete on a 8xx board, and the bugs seems to have a low
> probability.

Urghhhh... A bug is a bug is a bug, no matter how difficult it is  to
trigger  in test cases. It will become the show stopper in your first
presentation for the most important customer.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quote from the Boss after overriding the decision of a task force  he
created  to  find  a  solution:  "I'm  sorry  if  I ever gave you the
impression your input would have any effect on my  decision  for  the
outcome of this project!"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
