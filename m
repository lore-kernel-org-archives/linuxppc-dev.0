Message-ID: <3B608CA5.2A774BD9@seranoa.com>
Date: Thu, 26 Jul 2001 17:33:25 -0400
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root=/dev/ram0
References: <3B607757.6D4BFE4A@seranoa.com> <01072616453702.25105@sarge>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Ruhland wrote:
>
> Andrew,
>
> First make sure you are passing the correct boot args to the kernel:
>
>    root=/dev/ram0
>
> Is this echoed by the kernel during boot?

Yup.

>
> Also, make sure you have 'Second extended filesystem' support
> ('CONFIG_EXT2_FS=y' in .config) compiled into your kernel.
>

I definitely do

> That's really all I can suggest without more information.
>

What other informatin would be useful?  This has got me stumped.  The
ramdisk support in the kernel seems to be working OK.  I booted the
system up with an nfs mounted root partition and did the following:

	#dd if=/dev/zero of=/dev/ram0 bs=1k count=4096
	#dd if=/fs of=/dev/ram0    (fs is my filesystem image)

This went off without a hitch so I tried mounting /dev/ram0:

	#mount /dev/ram0 /mnt

also fine and when I look in /mnt the filesystem looks OK too.

Thanks,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
