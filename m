Date: Tue, 23 Dec 2003 19:11:55 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ashwin Bihari <raz0redge@hotmail.com>
Cc: mporter@kernel.crashing.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Intial ramdisk and kernel
Message-ID: <20031223191155.A27198@home.com>
References: <BAY9-F24HxekU9Cwu2I000aa743@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY9-F24HxekU9Cwu2I000aa743@hotmail.com>; from raz0redge@hotmail.com on Tue, Dec 23, 2003 at 06:58:01PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 23, 2003 at 06:58:01PM -0500, Ashwin Bihari wrote:
> >With the stock firmware on a PrPMC800, yes, you have to attach the
> >ramdisk to the kernel.  You do this by copying the compressed ramdisk
> >image to arch/ppc/boot/images/ramdisk.image.gz.  Then do a
> >'make zImage.initrd'.  That will deposit a zImage+initrd image into
> >arch/ppc/boot/images/.
>
> Matt,
>
> Ahh OK. Thank you for the details.
>
> >If you have a U-boot port to your board then you can be a lot more
> >flexible since it can load a kernel image and ramdisk separately.
> >
> >-Matt
>
> We are using PPCBug actually. Not sure if you're familiar with it's
> capabilities in comparison to U-boot in ramdisk booting ability.

Yes, very familiar with PPCBug.  That is the "stock firmware" I
mentioned above.  The resultant zImage+initrd image is bootable
from PPCBug.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
