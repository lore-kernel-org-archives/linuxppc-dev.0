Date: Wed, 30 Oct 2002 12:57:14 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel panic
Message-ID: <20021030125714.B31666@home.com>
References: <000701c27f86$9a27a5b0$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000701c27f86$9a27a5b0$370da8c0@aman>; from aman@mistralsoftware.com on Wed, Oct 30, 2002 at 01:36:00AM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 30, 2002 at 01:36:00AM +0530, Aman wrote:
>
> Hi All
>
> I am trying to build linux image with ramdisk and download to the PPC 440GP
> evalkit. Earlier the filesystem was using nfs mount, now I hv builded a
> zImage.initrd with ramdisk.image [I havent compressed the ramdisk image]. To
> build the ramdisk, I used the procedure defined by HHL.. I defined the
> ramdisk size as 8MB. However when I booted  with the image built. I am
> getting a kernel panic error. I have pasted the output below.  One question
> , how should we decide about the files to be loaded in ramdisk which will
> be needed by  kernel image.
>
> Thanking you in advance.
> Regards
> Aman
>
>
> Loading file "zImage.initrd" ...
> Sending tftp boot request ...
> Transfer Complete ...
> Loaded successfully ...
> Entry point at 0x1000000 ...
> loaded at:     01000000 018821BC
> zimage at:     01005950 0107E2C9
> initrd at:     0107F000 0187F000
> avail ram:     00400000 00800000
>
> Linux/PPC load: root=/dev/ram ramdisk_size=8192
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.4.17_mvl21-ebony (root@hardhat) (gcc version 2.95.3 20010315
	        ^^^^^^^^^^^^^^^^^^

Basic questions like this on a vendor-specific kernel (and a
"procedure defined by HHL") might be better answered by contacting
your vendor's support arm.

I have no problem with initrds using a ramdisk.image.gz created via
"dd if=/dev/zero ...", mke2fs, and populated via a loopback mount.
Looks like you have ramdisk size set properly...make sure the
filesytem (ext2) is built-in.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
