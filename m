Message-ID: <3F5664E8.3080502@ece.msstate.edu>
Date: Wed, 03 Sep 2003 17:02:16 -0500
From: Jan Dominik Baranski <jdb2@ece.msstate.edu>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel hangs on EP862-1.1 during boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,
I'm having trouble getting a 2.4.22 kernel to boot on an Embedded Planet
EP862-1.1 board (based on an MPC860). I get this:
---
Loaded addresses 00400000 through 0049FFFF.
 >go
[Go 00400000]

loaded at:     00400000 004A31F4
relocated to:  00180000 002231F4
board data at: 00220128 00220144
relocated to:  001862E0 001862FC
zimage at:     001868A0 0021F3EC
avail ram:     00224000 01000000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel

<just hangs here>

---
I've searched the archives, but no one seems to have this board/problem
combination. I've made sure the watchdog timer is disabled and that the
IMMR (0xfa200000) is set correctly. Being pretty new to this, I don't
really know where else to look. Maybe something related to m8xx_board_info?

The thing is, I've been able to get an old kernel (2.4.7) from Timesys
that's configured for an RPX Classic board to boot correctly. I just
can't figure out what they may have done that I haven't.

Any suggestions??

Thanks

-Jan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
