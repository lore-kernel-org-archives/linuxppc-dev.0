Message-ID: <3B607757.6D4BFE4A@seranoa.com>
Date: Thu, 26 Jul 2001 16:02:31 -0400
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: root=/dev/ram0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
I'm trying to mount a compressed ramdisk image on /dev/ram0 and run my
root filesystem from there.  My problem is that when I try to boot I get
the following error:

    VFS: Cannot open root device "ram0" or 01:00
    Please append a correct "root=" boot option

earlier in the boot process the ram disks are recognized:

    RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
blocksize

I'm using kernel 2.4.5-pre3 from Ben H's source.

Anyone know why the kernel isn't able to open /dev/ram0?

Thanks,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
