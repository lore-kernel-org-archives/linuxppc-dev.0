Message-Id: <sbd55c05.004@tms-pty.com>
Date: Tue, 23 Oct 2001 12:00:50 +1100
From: "Jeremy Rosen" <Rosen.Jeremy@tms-pty.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem using FEC on a860T
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


well, actually the patch worked only partially...

the driver compiles, and registers properly, but doesn't seem to handle
RPC correctly.

I have the following message :

when both fec and normal CPM ENET are compiled,
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get mountd port number from server, using default

then a second atempt on the default port, with the same error.

I have captured no packets on any of the interfaces.

when I compile only with fec ( no CPM ENET )

it blocks at
Looking up port of RPC 100003/2 on 172.16.0.1
I still can't capture any packets,
the feth enable led isn't lit,
and the collision and Tx leds of the board FOR THE CPM are blinking
continuously...

after a couple of seconds, the kernel starts scrolling
eth0: tx queue full!.

did I do something wrong ???
thx
Jeremy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
