From: "Jon Erick Ween" <jween@som.llu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.18pre18 kernel panic on Lombard
Date: Wed, 8 Nov 2000 15:18:47 -0800
Message-ID: <773744E7737.AAA39B0@som.llu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm trying to get my usb ports to work on my Lombard. I have 2.2.8pre17
running OK but without USB or 3-button emulation working (in console or X).
rsynced and compiled 2.2.18pre18 without problems but wind up in a kernel
panic after loading the adb mouse handler and pty configuration (see
below). Is this a problem with the new input layer (I don't seem to have
/dev/input/) or a problem with the Lombard's usb ports?

Thanks for any replies.

Jon

snip
...

ADB MOUSE @ 3 handler set to 4 (trackpad)
pty:256 unix98 ptys configured {Normal boot up to this point}
machine check in kernel mode (regs at c025fe00)
Caused by (from srr1): unknown values in srr1
NIP: C016C2B0 XER: 20000000 LR: C016c238 regs: c025fe00 TRAP: 0200
MSR: 00009030 [EE, IR, DR, ME]
TASK=c025e000[1] 'swapper' mm->pgd c0146000 last syscall: 120
...

etc.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
