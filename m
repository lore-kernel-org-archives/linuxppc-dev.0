Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 1F54D67C7B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 02:04:12 +1000 (EST)
To: "David Grab" <d.grab@hima.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Jul 2005 13:18:54 +0200."
	<000801c58153$54af2400$f201a8c0@SN7606>
Date: Tue, 05 Jul 2005 18:01:49 +0200
Sender: wd@denx.de
Message-Id: <20050705160149.3BDF7353A5E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: AW: initrd rootfs ramdisk 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000801c58153$54af2400$f201a8c0@SN7606> you wrote:
> 
> >But the kernel prints the boot parameters just fine.
> 
> Maybe because i defined it in kernel configuration! But from u-boot i don´t
> get any arguments.

Then you must be using a wrong image type. Are you sure you use "make
uImage" to build your kernel image for U-Boot?

> I thougt i can give the linux kernel position from u-boot where initrd is
> located, but i have the same problem.

You don;t. U-Boot passes this information automatically.

> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> VFS: Cannot open root device "<NULL>" or unknown-block(3,1)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(3,1)

Block device 3, 1 is /dev/hda1 - is your ramdisk known to be working?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The majority of the stupid is  invincible  and  guaranteed  for  all
time.  The  terror  of their tyranny, however, is alleviated by their
lack of consistency."                               - Albert Einstein
