Reply-To: <rey@mcg.mot.com>
From: "Rey Estrada" <rey@mcg.mot.com>
To: "Andrew Dixon" <andrew.dixon@seranoa.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: root=/dev/ram0
Date: Thu, 26 Jul 2001 15:13:34 -0700
Message-ID: <NDBBLFFANNIHADOLFAIDMEIBCBAA.rey@mcg.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3B608CA5.2A774BD9@seranoa.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You might want to try setting ramdisk_size too.  It's been a while since I
played with this stuff and the argument may be called something else.

Rey Estrada
Motorola Computer Group
2900 S Diablo Way
Tempe, AZ  85282


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Andrew Dixon
Sent: Thursday, July 26, 2001 2:33 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: root=/dev/ram0


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
