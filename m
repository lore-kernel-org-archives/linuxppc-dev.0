Date: Sun, 13 May 2001 15:39:53 -0700
From: Anton Blanchard <anton@samba.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel sound problems (and misc)
Message-ID: <20010513153953.A16897@va.samba.org>
References: <kara.5052-0.989768459@kara.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <kara.5052-0.989768459@kara.hadess.net>; from hadess@hadess.net on Sun, May 13, 2001 at 04:40:59PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> The misc problem is, while trying to compile paulus' kernel, the vmlinux
> target fails to link with rwsem_down_write_failed and rwsem_wake
> undefined references.

Did you make oldconfig? You should this in your .config:

# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
