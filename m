Date: Sun, 27 Jun 1999 19:46:49 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: sym53c8xx timeouts and aborts... egcs-1.1.2e problem??
Message-ID: <Pine.LNX.4.04.9906271940400.5764-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a Motorola MTX board, which I just tried to upgrade the kernel to
2.2.10 on.

I built the kernel on a PowerMac G3 which had 
binutils-2.9.1.0.990418-1c, egcs-1.1.2-12e, and glibc-2.1.1-6h installed.

When the sym53c driver loaded, it scanned the bus, and then proceeded to
go into an infinite loop of timeouts and aborts.

This occurs with the sym53c8xx and ncr53c8xx drivers on 2.2.10, *and* on
the same 2.2.3 based kernel sources I had previously been using
successfully on this machine.

The only thing that has I can think of that has changed is that the latest
kernels have been compiled with the new egcs.

Can anyone give me a success or failure report on an ncr/sym53c8xx board
on a kernel compiled with egcs-1.1.2-12e?

Thanks.

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
