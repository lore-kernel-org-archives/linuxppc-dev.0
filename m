Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 0882C679E8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 02:04:17 +1000 (EST)
Message-ID: <428B6948.8050202@ru.mvista.com>
Date: Wed, 18 May 2005 20:11:52 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: andreas_schmidt@ifm-electronic.com
References: <OFA7B343F9.F5611A71-ONC1257005.00521FFA-C1257005.00541DF8@ifm-electronic.com>
In-Reply-To: <OFA7B343F9.F5611A71-ONC1257005.00521FFA-C1257005.00541DF8@ifm-electronic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linux hangs after uncompressing on memec board with virtex2p
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andreas,

I've never tried using u-boot with the virtex2p boards,
but there is the AppNote describing how to use u-boot
with ML300 (it seems your port is based on ML300):

http://direct.xilinx.com/bvdocs/appnotes/xapp542.pdf

This appnote mentions the small patch needed by the linux kernel.
Are you sure you have applied this patch, or this patch is in the
kernel tree you are using already?
I mean the ml300.uboot.patch from xapp542.zip.

Best regards,
Andrei


andreas_schmidt@ifm-electronic.com wrote:
> Hi at all
> 
> 
> Since one week I have this Problem and can't solve it. I allready read DULG and search in
> Mailinglists but I can't run linux. Perhaps had the same problem and can help me.
> My Problem:
> After I load the uImage and initrd in Ram (uImage at 0x00400000 and initrd 0x00600000)
> from server, I try to run in with command bootm.
> => bootm 00400000 00600000
> 
> the outpu what I get is
> 
> ## Booting image at 00400000 ...
>    Image Name:   Linux-2.4.24-pre2
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    609180 Bytes = 594.9 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 00600000 ...
>    Image Name:   Simple Embedded Linux Framework
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    1476478 Bytes =  1.4 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Loading Ramdisk to 00697000, end 007ff77e ... OK
> 
> and than hangs it.
> I debug until the u-boot gives parameter on kernel (*kernel) (kbd, initrd_start,
> initrd_end, cmd_start, cmd_end); and all works fine.
> Than it can be only the kernel who hangs?
> 
> Some additional information to u-boot.

...
