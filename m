Date: Thu, 22 Jun 2000 13:15:10 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Can't mmap the top 1MB of /dev/mem?
Message-ID: <Pine.LNX.3.96.1000622130831.10550A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan (and all),

I've been playing w/ mmap for flash and nvram access on the rpxlite(MV
derived kernel). One thing I've noticed is that it won't let me mmap the
top 1MB of the address space.  I'm guessing that the region isn't
represented in the MMU stuff or this is a deliberate block in the /dev/mem
driver.

I've done a little digging on my own and haven't found the cause.  Can
anyone point me to the right file/function(s)?

Many Thanks,
-Mark

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
P.O. Box 941149            e-mail: mark@linux-wlan.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
