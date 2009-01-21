Return-Path: <jhautbois@gmail.com>
Received: from mail-bw0-f14.google.com (mail-bw0-f14.google.com
	[209.85.218.14]) by ozlabs.org (Postfix) with ESMTP id 4A322DDF47
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 03:15:46 +1100 (EST)
Received: by bwz7 with SMTP id 7so131220bwz.16
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 08:15:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1232552530.7186.5.camel@penguin>
References: <496F318D.6010302@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>
	<1232552530.7186.5.camel@penguin>
Date: Wed, 21 Jan 2009 17:15:42 +0100
Message-ID: <8cad0aa0901210815q730730e7md31f32900ea4c1e5@mail.gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: jeff angielski <jeff@theptrgroup.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am now trying to use an initial RAM filesystem.
I have this:

"checking if image is initramfs... it is"
And then, after some hardware detections:
"List of all partitions:
1f00            8192 mtdblock0 (driver?)
No filesystem could mount root, tried:  ext3 ext2 cramfs
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
Rebooting in 180 seconds..."

When using a NFS root file system, it is ok.
I have passed these args to my kernel:

bootargs root=/dev/ram ro init=/linuxrc noapic acpi=off nofb

I tried also root=/dev/ram0 but it is not working better.
My kernel .config contains:
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192

Do I need to have MTD_RAM = y ?
Is there any other thing I should set to Y for it to work ?

Thx & Regards,
JM
