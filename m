Message-ID: <20040315105019.26478.qmail@web12502.mail.yahoo.com>
Date: Mon, 15 Mar 2004 02:50:19 -0800 (PST)
From: Stergios Spanos <stergios_s@yahoo.com>
Subject: Kernel 2.6.3 performance issue on MPC8260
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody!

We are currently migrating to kernel 2.6.3 on our
MPC8260 custom board.
The porting has been successfully completed.
Nevertheless we are facing some performance problems.

The board is to be impement layer 3 routing (over
Ethernet) functionality. Here is the description of
the problem.

We are testing the layer 3 routing performance of the
board. When we try to route let's say 300,000 packets
over a certain time period
through the processor , it is not able to handle all
the load and only routes around 200,000 packets. This
is fine and is due to the processor/software
limitations. This shows however that the "routing
limit" of the processor is around 200,000.

The strange thing that happens is that when we try to
route a smaller amount of data e.g 100,000 packets,
the processor still cannot manage to route all of them
and still routes only 90,000 packets.

My question is why does the proccessor refuses to
route 100,0000 (or even less) packets since it is able
to route much more packets (200,000) over the same
period of time.

The same set of tests has been performed on the board
using a 2.4.20 kernel. The results were more
predictable. Again when we try to route 300,000
packets over a certain period of time the processor
routes only around 200,000 (this is its limit). But
when we try to route 180,000 packets, the processor
routes them all fine.

At the time of the test the processor in not loaded
with any other tasks.

Any advice will be greatly appreciated.

Thanks!

Stergios.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
