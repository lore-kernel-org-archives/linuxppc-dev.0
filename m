Message-Id: <200101190658.HAA00760@piglet.grunz.lu>
Date: Fri, 19 Jan 2001 07:58:13 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Problem with FEC on CLLF
To: mgopik@yahoo.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010103152029.51915.qmail@web11108.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   3 Jan, this message from gopi krishna echoed through cyberspace:
> If we connect this to our switch *through a
> hub*(100mbps half duplex), everything is working fine.
>
> If we connect this directly to the switch, both the
> switch and the cllf show the link status to be up and
> connected(100mbps, half duplex), but ping doesnt work.
>
> We have noticed that the switch recieves the
> packets(frames) that the cllf is sending on the fec
> port,  the switch is sending some frames to the cllf
> fec port, but cllf doesnt receive even a single frame.
>
> Any pointers to the possible problem/solution?

I have seen things like that happen with bad cables. 100 Mb/s is very
sensitive to cable quality. Use a good, commercial-grade pre-built
cable, not homemade.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
