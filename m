Message-ID: <885489B3B89FB6449F93E525DF78777F06457C@srvnt506.ALLOPTIC.COM>
From: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: bdi2000
Date: Mon, 27 Jan 2003 17:06:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am having some difficulty setting up to work with the abatron bdi2000.  Is
there a mailing list somewhere I can post questions?

Since I am here,  can someone tell me what have I configured incorrectly on
the bdi2000.

I followed the document "Using the Abatro BDI2000 to Debug a Linux Kernel",
and for some reason,
without setting any breakpoint, the bdi2000 always seem to break somehwere
after the print on the console:

Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX



When I do an "info" in the bdi telnet window, this is what I got
- TARGET: target has entered debug mode
BDI>info
    Target state      : debug mode
    Debug entry cause : system call
    Current PC        : 0xc0005ebc

Without the BDI2000, the kernel comes up without a problem.

Thanks

Cecilia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
