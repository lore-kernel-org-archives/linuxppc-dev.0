Message-Id: <4.2.2.20040519135413.04c21930@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 13:54:38 -0700
To: Wolfgang Denk <wd@denx.de>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: /dev/ram in ramdisk_image.gz 
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040519211120.B4177C109F@atlas.denx.de>
References: <Your message of "Wed, 19 May 2004 13:09:46 PDT." <4.2.2.20040519130806.050a0340@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ext2 is configured in the kernel.

At 11:11 PM 5/19/04 +0200, Wolfgang Denk wrote:

>In message <4.2.2.20040519130806.050a0340@bhawley.mailhost.luminex.com>
>you wrote:
> >
> > Does anyone know if the ramdisk_image.gz on the DENX site for the ppc has
> > the /dev/ram device
> > already created?
>
>Yes, it has. But it doesn't need to. The kernel cannot look into /dev
>before mounting the root filesystem anyway.
>
> > When we boot an initrd [ created using mkimage from uboot on the
> > ramdisk_image.gz ], we get
> >
> > Kernel panic: VFS: Unable to mount root fs on ram0
> > <0>Rebooting in 180 seconds..<6>eth0: Link is Up
>
>Must be a problem with your kernel and/or your  kernel  configuration
>(for example: do you have ext2 support enabled?).
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Things are not as simple as they seem at first.        - Edward Thorp
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
