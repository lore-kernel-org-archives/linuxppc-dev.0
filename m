Message-ID: <3B60D970.7080201@brocade.com>
Date: Thu, 26 Jul 2001 20:01:04 -0700
From: Amit D Chaudhary <amitc@brocade.com>
MIME-Version: 1.0
To: Andrew Dixon <andrew.dixon@seranoa.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root=/dev/ram0
References: <3B607757.6D4BFE4A@seranoa.com> <01072616453702.25105@sarge> <3B608CA5.2A774BD9@seranoa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,


Can you give the following details,
Are you trying to load it as initrd? Not I assume, else confirm that
CONFIG_BLK_DEV_INITRD=y

Incase you are setting /dev/ram0 as the rootfs using rdev or equivalent,
how does the rootfs end up on the ramdisk when the kernel starts up?

Amit

ps - Did not mean to skip the list.

Andrew Dixon wrote:

> Paul Ruhland wrote:
>
>>Andrew,
>>
>>First make sure you are passing the correct boot args to the kernel:
>>
>>   root=/dev/ram0
>>
>>Is this echoed by the kernel during boot?
>>
>
> Yup.
>
>
>>Also, make sure you have 'Second extended filesystem' support
>>('CONFIG_EXT2_FS=y' in .config) compiled into your kernel.
>>
>>
>
> I definitely do
>
>
>>That's really all I can suggest without more information.
>>
>>
>
> What other informatin would be useful?  This has got me stumped.  The
> ramdisk support in the kernel seems to be working OK.  I booted the
> system up with an nfs mounted root partition and did the following:
>
> 	#dd if=/dev/zero of=/dev/ram0 bs=1k count=4096
> 	#dd if=/fs of=/dev/ram0    (fs is my filesystem image)
>
> This went off without a hitch so I tried mounting /dev/ram0:
>
> 	#mount /dev/ram0 /mnt
>
> also fine and when I look in /mnt the filesystem looks OK too.
>
> Thanks,
> Andy
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
