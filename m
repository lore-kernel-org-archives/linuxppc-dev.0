Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id ED94A67CB2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jul 2005 22:46:56 +1000 (EST)
To: =?iso-8859-1?Q?=22H=E4pe=2C_Sebastian=2C_HRD/AB=22?=
	<sebastian.haepe@eads.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 20 Jul 2005 12:35:16 +0200."
	<2D9AB865A49FD511914700105A0EF6790252BDCE@morse.smart.lfk.eads.net>
Date: Thu, 21 Jul 2005 14:46:38 +0200
Sender: wd@denx.de
Message-Id: <20050721124638.21ACA3525B2@atlas.denx.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: Problem mounting ramdisk image 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <2D9AB865A49FD511914700105A0EF6790252BDCE@morse.smart.lfk.eads.net> you wrote:
> 
> I have a litte problem with an initrd-image on a custom board:

It is considered a good idea to search a  bit  in  the  mailing  list
archives  before  posting.  If you had done so, you should have found
several similar requests before (even within the last few  days)  and
saved us all the effort to reiterate the whole thing again.

> Now the following effects occur:
> 
>  -  if i do not tell the kernel which filesystem I have in my image (only
> entering: 'root=/dev/ram rw init=/bin/busybox')

You do not tell it to the kernel, and you don't tell us. This is  not
really helpful. So what is it? ext2?

>     RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 > blocksize
>     RAMDISK: Compressed image found at block 0

Good.

>     Freeing initrd memory: 709k freed
>     Kernel panic: VFS: Unable to mount root fs on 01:00

Did you enable ext2 support in your kernel configuration?


>  -  if I tell the kernel to use TMPFS or RAMFS (rootfs=tmpfs or
> rootfs=ramfs), the error is

You get what you ask for: garbage in, garbage out.

> My distribution (ELinOS) creates two files, 'Image.gz' and > 'Image.initrd'.
> If I extract Image.gz, the full filesystem is extracted. 
> How can I check wheather the 'Image.initrd' file is correct?

How should we know which commands your  distribution  uses  to  build
these images? They can contain anything.

> (U-Boot tells me it is correct if I enter 'imi [address of image]')

Grrrghh.. I wich you had posted complete information at least  for  a
single of your questions. And which sort of image type is reported by
U-Boot?

> Or does anyone did have the same problem? Have I forgotten any kernel
> options?

Yes, many people have asked the same before. It's all in the archives.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
When in doubt, mumble;   when in trouble, delegate;  when in  charge,
ponder.                                             -- James H. Boren
