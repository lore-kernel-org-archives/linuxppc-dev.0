From: "Jon Erick Ween" <jween@som.llu.edu>
To: bh40@calva.net
Cc: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.18pre21 kernel panic on a lombard
Date: Wed, 15 Nov 2000 18:52:15 -0800
Message-ID: <773747F2145F.AAA27FE@som.llu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'm trying to get my usb ports to work on my Lombard. I have 2.2.8pre17
>running OK but without USB or 3-button emulation working (in console or
X).
>rsynced and compiled 2.2.18pre18 without problems but wind up in a kernel
>panic after loading the adb mouse handler and pty configuration (see
>below). Is this a problem with the new input layer (I don't seem to have
>/dev/input/) or a problem with the Lombard's usb ports?
>
>Thanks for any replies.
>
>Jon
>
>snip
>...
>
>ADB MOUSE @ 3 handler set to 4 (trackpad)
>pty:256 unix98 ptys configured {Normal boot up to this point}
>machine check in kernel mode (regs at c025fe00)
>Caused by (from srr1): unknown values in srr1
>NIP: C016C2B0 XER: 20000000 LR: C016c238 regs: c025fe00 TRAP: 0200
>MSR: 00009030 [EE, IR, DR, ME]
>TASK=c025e000[1] 'swapper' mm->pgd c0146000 last syscall: 120
>...

When reporting a panic like that, you should also lookup in your System.map

where those various addresses are, or your report is useless.

The important ones are the NIP, LR and addresses in the backtrace.

Ben

I cannot find ANY references to the NIP, LR or backtrace addresses given
during boot up (eg: c016c2b0) in System.map at all. Are there supposed to
be? things work fine when I boot my older 2.2.17 kernel. The 2.2.18pre21
(and pre18) kernels seem to be bombing when trying to load the ADB mouse
driver. I've tried with kernels using both the old drivers and the input
layer (though I don't have any /dev/input files anyway). Both ways crash.
Any suggestions?

Jon


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
