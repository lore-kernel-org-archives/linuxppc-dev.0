From: Benjamin Herrenschmidt <bh40@calva.net>
To: Jon Erick Ween <jween@som.llu.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.18pre18 kernel panic on Lombard
Date: Thu, 9 Nov 2000 12:57:22 +0100
Message-Id: <19341004052906.6276@192.168.1.2>
In-Reply-To: <773744E7737.AAA39B0@som.llu.edu>
References: <773744E7737.AAA39B0@som.llu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'm trying to get my usb ports to work on my Lombard. I have 2.2.8pre17
>running OK but without USB or 3-button emulation working (in console or X).
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

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
