Message-ID: <002501c1a649$ef2b4ba0$74b0f8cb@bluecafe>
From: "ChangYl Lee" <bluecafe@sgi21.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Booting linux-2.4.18-pre7 with IBM405GP(rev E)
Date: Sat, 26 Jan 2002 18:15:01 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all..!
I'm going to develop new board based on a IBM405GP(rev. E) processor and I cloned linux_2_4_devel and tested it.

kernel version is 2.4.18-pre7 and default config is set to walnut_defconfig.

Attempting to debug, I've found out my kernel is stopped or hung at real address 0.
Before jumping address 0, it seems to be nice and I can see my debug character with serial console.
but I can't see my debug character start of "start_here:" at arch/ppc/kernel/head_4xx.S

I've read posted message titled "booting HardHat on IBM405GP" but still I can't understand.
The output of the booting message looks like this:
-----------------
MON> go
Linux porting start.... press any key..

loaded at:     00250000 002E8238
board data at: 002E5168 002E51A8
relocated to:  002E5128 002E5168
zimage at:     00255B30 002E4CCB
avail ram:     002E9000 04000000

Linux/PPC load: console=ttyS0,115200 root=/dev/ram rw debug ram=64m
Uncompressing Linux...done.
Now booting the kernel
----------------

Any help is greatly appreciated.

------------------------------------------------------------
Be happy..!
ChangYl, Lee : bluecafe@sgi21.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
