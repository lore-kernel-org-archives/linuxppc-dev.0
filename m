Message-ID: <3DD98FD4.3020804@gmx.de>
Date: Tue, 19 Nov 2002 09:11:48 +0800
From: Michael Habermann <mhabermann@gmx.de>
MIME-Version: 1.0
To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: glibc 2.2.2  error
References: <20021118122042.74002.qmail@web8001.mail.in.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


rekha gvv wrote:

>
>
>../linuxthreads/sysdeps/unix/sysv/linux/bits/local_lim.h:36:26:
>linux/limits.h: No such file or directory
>
You have to create a symbolic link to the kernels include/linux and
include/asm directory into the /usr/local/powerpc-linux/include directory.
e.g.
cd /usr/local/powerpc-linux/include
ln -s /usr/src/ppclinux/include/linux
ln -s /usr/src/ppclinux/include/asm

The kernel source has to exist for that and the kernels make menuconfig
had to be called earlier.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
