Date: Fri, 5 Apr 2002 21:35:34 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: SCSI system freeze w/2.4.18
To: albrecht.dress@arcor.de
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020404195209.GG30247@regulus>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16tZUq-00007a-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey,

On   4 Apr, this message from Albrecht Dre? echoed through cyberspace:
> I upgraded my PowerMac 7300 from 2.4.6-pre3 to (stock) 2.4.18, and since
> then I have a nasty scsi problem: Trying to read data from the cd drive
> without a cd loaded (e.g. "dd if=/dev/scd0 of=/dev/null bs=1 count=1")
> freezes the machine.

Hmm, I tried your dd command on my 7600 this morning, and I see weird
things as well.

In fact, the system doesn't do _any_ disk access as long as the dd
command sits there waiting for the cdrom. dd is unkillable, and it seems
no other disk access is possible as long as dd waits.

I can still switch desktops in X, i can type in my xterms, but I cannot
start a new command (needs to load the binary from disk...), and all
existing processes that need to read from disk are blocked.

Inserting a CD makes the dd command complete, and the system unfreezes.

This is with stock (more or less; unrelated local changes) 2.4.16. Not
sure how older kernels behaved....


Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
