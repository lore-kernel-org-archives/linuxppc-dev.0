Date: Fri, 16 Jul 1999 20:52:22 -0500
Subject: Beige UW crashes
From: "Chris Clark" <cclark@ticnet.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <E115JdS-000146-00@smtp.ticnet.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been having the worst time trying to get LinuxPPC (both r4 and r5) to
work with my 333MT beige MAc with the Apple supplied UW card.  I have tried
bootx 1.1 and 1.1.1 as well as numerous kernels with support for the ncr
(ATTO) UW card.  I have tried vmlinux4, and several of the kernels from
skinnydesign.  I have yet to find a stable combination.  I am beginning to
believe that I have a hardware problem.  I replaced my keyboard and mouse
cables (explanation in a moment), removed (and switched) ram from the
machine and disconnected all other peripherals.

The problem I am having is the machine kernel panics either during the boot
sequence (right as it's probing the UW drive or during the first few min of
operation (usually not more than five min).  Somtimes, however, I can keep
it running for a while, but that is only if I don't move the mouse or type
anything (hence changing the cables...I also switched keboards and mice, to
no avail)  The kernel panic is allways the exactly the same regardless of
how long the machine is up or when it panics (at boot or after) and I was
wondering if anyone could shed some light as to what may be the problem.

I am thinking of buying a 2940UW hoping that will fix the problem but I
wanted to get some feed back from someone who may could help diagnose the
problem so I don't waste my money.

An exerpt of the message is:

machine check    trap: 0200
Task=C0181fd8[0] 'swapper' mm->pgd C017f000
LAst sys call: 112
Last Math: c5dc000
call backtrace C01A0000 C00003A80 C001C6FC C0005AB4
C0005ADC C000388C 0C0B53D0
Kernel panic - swapper task not syncing

This has to be one of the most frustrating things I have ever dealt with
with linux.  Just as soon as I think I have the problem fixed....it boots, I
log in and type for a couple of min or click on a window and *crash* , never
more than 10 min use.

If anyone could give me a hand, especially those with similar machines (how
long does everyone elses 333/UW stay up?) I would be eternally gratefull.  I
have some work I need to do with this machine and I would really like to do
it with Linux.

Thank you in advance,

Chris Clark
cclark@ticnet.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
