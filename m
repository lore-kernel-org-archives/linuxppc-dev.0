Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <v04011700b2b80bfaa277@[209.86.156.99]>
In-Reply-To: <3691F885.77C7D466@mpifr-bonn.mpg.de>
References: <v04011700b2b76717bf6b@[209.86.156.101]>
Date: Tue, 5 Jan 1999 10:49:17 -0800
To: <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Strange PMAC IDE performance problem
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:33 PM +0100 1/5/99, Albrecht Dreß wrote:

>I can confirm this behaviour on my PowerBook G3/300 with almost the same rate
>under 2.1.130 (the disk is an IBM DYLA 28100). Furthermore, the whole system
>nearly freezes under heavy io load (I simply used a program which writes and
>reads blocks of data to/from the disk using read and write calls in a loop;
>during the run the reaction to console input or a "cat" needs several seconds,
>etc.). I posted this problem several times, but got no reaction, so I am glad
>that I am not alone ... :-(
>
>The problem might be connected to LOADS of "Bogus interrupts" from do_IRQ in
>arch/ppc/kernel/irq.c (try "dmesg" and do a "cat /proc/interrupts" before and
>after your test; you will see the increase in the "BAD" line).

Interesting -- I don't get any bogus interrupts on either of my machines.
I also don't experience such harsh penalties to system responsiveness if
there's a lot of I/O going on -- I often use grep with find supplying the
filenames to recursively search the kernel source tree, which cranks the
disk quite a bit, and have no problems using other programs while it's
churning away.

I would guess that you have the same performance problem along with some
serious bug that for some reason is only showing up on your machine (as I
believe there are many other people using PowerBook G3 Series machines
without such problems).

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
