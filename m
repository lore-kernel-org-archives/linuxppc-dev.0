MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: kernel system calls
Date: Wed, 9 Jul 2003 09:07:13 -0500
Message-ID: <45E73EE17E678C4081B8A09E651628D234ACD1@atlas.info-engineering.com>
From: "Collins, Steve" <Steve.Collins@dynetics.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

When I #define __KERNEL_SYSCALLS__ in my driver in order to use system
level calls within kernel space and recompile my code I receive the
following errors within the unistd.h header file:

In function 'pause':
'errno' undeclared

This error repeats for every system call within the #ifdef area of
KERNEL_SYSCALLS in unistd.h.  Any comments or suggestions for a fix will
be appreciated.

Thanks,
Steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
