MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16140.46018.877389.499834@cargo.ozlabs.ibm.com>
Date: Thu, 10 Jul 2003 10:30:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Collins, Steve" <Steve.Collins@dynetics.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel system calls
In-Reply-To: <45E73EE17E678C4081B8A09E651628D234ACD1@atlas.info-engineering.com>
References: <45E73EE17E678C4081B8A09E651628D234ACD1@atlas.info-engineering.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Collins, Steve writes:

> When I #define __KERNEL_SYSCALLS__ in my driver in order to use system
> level calls within kernel space and recompile my code I receive the
> following errors within the unistd.h header file:
>
> In function 'pause':
> 'errno' undeclared
>
> This error repeats for every system call within the #ifdef area of
> KERNEL_SYSCALLS in unistd.h.  Any comments or suggestions for a fix will
> be appreciated.

How about #include <linux/errno.h> ?  :)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
