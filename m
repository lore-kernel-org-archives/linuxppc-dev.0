Message-ID: <38AA0E9C.619E523@huawei.com.cn>
Date: Wed, 16 Feb 2000 10:42:36 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: initrd question...
References: <0FPX00FFH0XJV5@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:
    Now I want to get my initrd running. I use the ramdisk demo "ramdisk.image.gz" under
arch/ppc/mbxboot and compile my zvmlinux.initrd.
    The target boots correctly at the beginning. It decompresses the kernel and runs the kernel and
shows the boot messages. When all is done, it begins to mount root filesystem (on Ramdisk), and shows
the following messages:
        RAMDISK:Compressed image found at block 0
        VFS:Mounted root (ext2 filesystem)
         Freeing unused kernel memory:28k init
Then nothing happen.
At this time it should show the shell prompt. But I don't know why it didn't show. And I couldnot input
any character.
Cross-compile environment:
[binutils-2.9.1.0.19a        egcs-1.1.2           glibc-2.1(including crypt, linuxthreads)]
I cross-compile my kernel under the above environment.
Any suggestions will be highly appreciated.
Thank in advance
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
