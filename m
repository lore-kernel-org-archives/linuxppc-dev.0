In-Reply-To: <v04011700b2b80bfaa277@[209.86.156.99]>
Date: Tue, 5 Jan 1999 23:48:15 +0100
To: linuxppc-dev@lists.linuxppc.org, "Timothy A. Seufert" <tas@mindspring.com>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Strange PMAC IDE performance problem
Message-Id: <19990105234815.008275@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 5, 1999, Timothy A. Seufert <tas@mindspring.com> wrote:

>Interesting -- I don't get any bogus interrupts on either of my machines.
>I also don't experience such harsh penalties to system responsiveness if
>there's a lot of I/O going on -- I often use grep with find supplying the
>filenames to recursively search the kernel source tree, which cranks the
>disk quite a bit, and have no problems using other programs while it's
>churning away.
>
>I would guess that you have the same performance problem along with some
>serious bug that for some reason is only showing up on your machine (as I
>believe there are many other people using PowerBook G3 Series machines
>without such problems).

I remember Cort having tons of them initially with his PowerBook and they
disappeared, I don't know if it was after a kernel change however.

On my PowerBook G3 Series (250MHz first gen.), I have occasionally a
couple of bogus interrupts during boot and ADB probing (seems to be
related to high PMU acitivity but I have not really tracked them) and
some date reading problems (the problem appeared twice in several month,
usually persistent accross reboots, and after 1 or 2 days, it disappears
again). Those are the only apparently random problems I'm having. Also,
the IDE is not very fast (looks slower than MacOS) but this may be due to
Linux not using full features of the controller in G3 Series (according
to a very vague statement of Apple, it should be improved but nothing
precise enough however).

I never experienced the slowdown+crash on heavy i/os, even when copying
full kernel trees locally, over NFS and both at the same time.

Is there some common denominator with all those problems ? For example, I
never connect anything to my PowerBook's MESH. Did the people with the
problem have something connected to it ? never ? always ? both ? Maybe we
could collect the disk models to see if the seem to be related. Also, are
the problem similar when booting with OF and BootX or are there any
differences ?

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
