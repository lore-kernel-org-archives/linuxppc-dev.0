Message-ID: <38EDDD7F.B1925A48@iname.com>
Date: Fri, 07 Apr 2000 14:07:11 +0100
From: Jim Chapman <jim.chapman@iname.com>
MIME-Version: 1.0
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: ppc inline assembly in h files
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having problems getting some of my inline asm() code to work.
Browsing the kernel's include/asm-ppc to see how things are done by the
kernel, I notice that the atomic functions in include/asm-ppc/atomic.h
are commented out. Is this due to compiler issues? Is there a version of
gcc that allows such functions to be inlined in asm() statements? When
can inline asm() be used safely?

Thanks

-Jim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
