Date: Fri, 28 May 2004 07:54:09 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: newly-updated linuxppc-2.5 tree compiles but fails to boot
Message-ID: <Pine.LNX.4.58.0405280746270.26869@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  just this morning, i did a fresh checkout of the linuxppc-2.5 BK repo
and, using the same .config file as i have for a while, got a clean
compile (yee ha), building for 8xx.

  sadly, unlike previous times where i could then boot that kernel up to
user space, this kernel hung almost immediately:

Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0 init=/bin/sh
Uncompressing Linux...done.
Now booting the kernel

... and that was it.  just as i head back to check things out more
carefully, would any of the recent changes require any obvious mods to the
config file?  sorry i'm not enough of a kernel expert to know how to dig
into this further, but i'm working on it.


rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
