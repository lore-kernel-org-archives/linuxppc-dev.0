Date: Tue, 5 Jan 1999 11:52:40 -0600 (CST)
Message-Id: <v03110700b2b7abbf9cdd@[129.59.235.1]>
In-Reply-To: <3691F885.77C7D466@mpifr-bonn.mpg.de>
References: <v04011700b2b76717bf6b@[209.86.156.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: LinuxPPC-Dev List <linuxppc-dev@lists.linuxppc.org>
From: "Marcus H. Mendenhall" <mendenmh@nashville.net>
Subject: Re: Strange PMAC IDE performance problem
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Timothy A. Seufert wrote:
>[snip]
>> Needless to say, the IDE performance figures are far less than those drives
>> are capable of!  Under MacOS they benchmark much higher (for example, the
>[snip]
>
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

It goes beyond just temporary freezes/slowdowns.  After heavy i/o activity
on my G3 (rev2)/300 desktop machine, I get total freezes.  If I am out of X
(very rare...) I get a kernel stack overflow panic and a backtrace.  In X,
I get no chance to see the message.  I have not yet succeeded in copying
down enough of the message before the kernel autoreboots to be useful
(since it has only happened about twice when I was not in X).  If I
recompile a large package (ROOT, for example (a great scientific package
from root.cern.ch, incidentally)) I have nearly a 100% chance of at least
one such lockup during the operation.

I have never had enough time between the time the machine starts to slow
down and when it panics to look at dmesg and see the errors there.

This is the only serious problem I know of in kernels of the 2.1.130
vintage.  My machine at home (a 7300/180) has been running with absolutely
no problems of any type on the recent kernels.  If anyone who is following
this problem needs more info (for example the detailed backtrace) to help
debug, I will try to provoke it when not in X and hand-copy the info.  If
enough of that information has already been collected, I don't want to
spend a lot of time going through the exercise.

Looking forward to a solution... (and don't have time myself at present to
put out this particular fire)

Thanks in advance

Marcus Mendenhall



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
