Return-Path: <gregoire.banderet@ge.com>
Message-ID: <48EA3158.4040204@ge.com>
Date: Mon, 06 Oct 2008 17:40:08 +0200
From: Gregoire Banderet <gregoire.banderet@ge.com>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: Free memory, include "cached"?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have to report the amount of FreeMem on my embedded system. The rootfs
is in RAM. I use /proc/meminfo.
I started by doing : freemem = MemFree + Buffers + Cached
But I realized (tell me if I'm wrong) that my rootfs filesystems is
counted in "Cached".
Part of the memory in "Cached" can be allocated, so I should add it as
Free Memory, but part of it is my rootfs (i.e. really used).
How should I compute freemem ?

Note that with linux 2.4 (initrd and not initramfs) I did use the ioctl 
BLKGETSIZE in order to subtract the amount of memory used by the rootfs. 
But now with initramfs it's dynamic.

Thanks,
Greg
