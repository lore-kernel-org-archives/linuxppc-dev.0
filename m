Content-Type: text/plain;
  charset="iso-8859-1"
From: Paul Ruhland <pruhland@microwavedata.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root=/dev/ram0
Date: Thu, 26 Jul 2001 16:45:37 -0400
References: <3B607757.6D4BFE4A@seranoa.com>
In-Reply-To: <3B607757.6D4BFE4A@seranoa.com>
MIME-Version: 1.0
Message-Id: <01072616453702.25105@sarge>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrew,

First make sure you are passing the correct boot args to the kernel:

   root=/dev/ram0

Is this echoed by the kernel during boot?

Also, make sure you have 'Second extended filesystem' support
('CONFIG_EXT2_FS=y' in .config) compiled into your kernel.

That's really all I can suggest without more information.


On Thursday 26 July 2001 04:02 pm, you wrote:
> Hi All,
> I'm trying to mount a compressed ramdisk image on /dev/ram0 and run my
> root filesystem from there.  My problem is that when I try to boot I get
> the following error:
>
>     VFS: Cannot open root device "ram0" or 01:00
>     Please append a correct "root=" boot option
>
> earlier in the boot process the ram disks are recognized:
>
>     RAMDISK driver initialized: 16 RAM disks of 4096K size 1024
> blocksize
>
> I'm using kernel 2.4.5-pre3 from Ben H's source.
>
> Anyone know why the kernel isn't able to open /dev/ram0?
>
> Thanks,
> Andy
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
