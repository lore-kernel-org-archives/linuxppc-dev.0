Date: Thu, 23 Mar 2000 16:50:05 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Disabling interrupts
Message-ID: <Pine.LNX.4.21.0003231641120.31824-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I need to disable interrupts for a short time from a user program on
RPX/Lite. This needs to be done only once, but it's absolutely essential
that the program is not interrupted during a certain period of time.

Using the __cli() function from the kernel sources in a user-space program
doesn't work. The first instruction "mfmsr %r0" (Get current interrupt
state) causes SIGILL.

Probably I could hack the kernel to make processes with very high priority
uninterruptible.

I'm quite sure that the problem is not new. Anybody has a better idea?

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
