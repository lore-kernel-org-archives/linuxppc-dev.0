Date: Wed, 8 Sep 1999 15:02:20 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Paul's devel branch on Lombard?
Message-ID: <19990908150220.A21029@io.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm using Pauls' stable branch (2.2.12) from his rsync archives
on my Lombard PowerBook.  I've wanted to use the power management
features in the new kernels, but I have yet to build a kernel that
fully boots.  

As of today's kernel sources, it boots but pulls a Machine Check in 
one of my init scripts.  Each time I boot it, it does in a different place.
The attached dump is failing on the "exim" script ("S20exim").

I'm using the same kernel configuration I'm using for 2.2.12 (which
works great from the SCSI to the modem to the framebuffer to USB),
but 2.2.12 doesn't offer sleep mode.  :)

A hand-typed dump appears below.  I'll send my .config if it would
help.

Machine check in kernel mode.
Caused by (From msr): regs c75dbd10 Unknown values in msr
NIP: C000BDCC XER: 00000000 LR: C0011DD0 REGS: c75dbd10 TRAP: 0200
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c75da000[111] 'S20exim' Last syscall: 90
last math c75da000
GPR00: B6337806 C75DBDC0 C75DA000 BB04D805 01743000 0007FFC0 C037BCC0 C037BCE0
GPR08: 00000008 00000001 00000000 00000001 24842224 018CF840 00000000 01808294
GPR16: 00000000 30056500 7FFFE408 30056530 00009032 075DBE80 00000000 C7D4CB00
GPR24: 01745000 01742000 01745000 00003000 01745000 C02CD220 FE8BCFFF 01743000
vector: 200 at pc = c000bdcc, msr = 9030, sp = c75dbdc0 [c75dbd10]
current = c75da000, pid = 111, comm = S20exim

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
