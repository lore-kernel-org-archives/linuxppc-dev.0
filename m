From: "Ashwin Bihari" <raz0redge@hotmail.com>
To: mporter@kernel.crashing.org
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Intial ramdisk and kernel
Date: Tue, 23 Dec 2003 18:58:01 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY9-F24HxekU9Cwu2I000aa743@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>With the stock firmware on a PrPMC800, yes, you have to attach the
>ramdisk to the kernel.  You do this by copying the compressed ramdisk
>image to arch/ppc/boot/images/ramdisk.image.gz.  Then do a
>'make zImage.initrd'.  That will deposit a zImage+initrd image into
>arch/ppc/boot/images/.

Matt,

Ahh OK. Thank you for the details.

>If you have a U-boot port to your board then you can be a lot more
>flexible since it can load a kernel image and ramdisk separately.
>
>-Matt

We are using PPCBug actually. Not sure if you're familiar with it's
capabilities in comparison to U-boot in ramdisk booting ability.

~ Ashwin

_________________________________________________________________
Make your home warm and cozy this winter with tips from MSN House & Home.
http://special.msn.com/home/warmhome.armx


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
