From: "Q-ha Park" <qha@infoeq.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: can't find "init" when using 1GB ram on 7455.
Date: Wed, 1 Oct 2003 00:44:59 +0900
Message-ID: <007601c38769$ceb77030$2a21a8c0@qha>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, actually not just init but all "start" programs such as modprobe,
bash, etc. Linux uses NFS as its filesystem, and kernel thinks NFS is
mounted correctly, but it doesn't successfully find and execute "start"
programs like sh, init, etc. The system that works well with 512MB ram.

This is what I attempted to support two 512 MB DIMM rams:
1. use 2 more BATs to translate up to 0x40000000 (1GB) in ppcboot,
changed CFG_INIT_RAM to 0x40000000 accordingly.
2. enable high_mem support in the kernel.

When I made the system load the kernel w/o high_mem support
intentionally, UART doens't work anymore; it doesn't generate interrups.
Any clues on what might be wrong and what idiotic things I might have
done?

Thanks in advance!

:::::::::::::::::::::::::::::::::::::::::::::::::
Q-ha Park


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
