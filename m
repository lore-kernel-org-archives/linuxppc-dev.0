Date: Tue, 23 Dec 2003 16:50:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ashwin Bihari <raz0redge@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Intial ramdisk and kernel
Message-ID: <20031223165049.A26159@home.com>
References: <BAY9-F52DvaPK7835U4000107f3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY9-F52DvaPK7835U4000107f3@hotmail.com>; from raz0redge@hotmail.com on Tue, Dec 23, 2003 at 04:54:42PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 23, 2003 at 04:54:42PM -0500, Ashwin Bihari wrote:
> >From my reading these lists and other forums, it seems that with the PPC
> platform, I have to compile the INITRD into the kernel, how do I go about
> doing this???
>
> I'm using a PrPMC800 based installation. Any and all help appreciated.

With the stock firmware on a PrPMC800, yes, you have to attach the
ramdisk to the kernel.  You do this by copying the compressed ramdisk
image to arch/ppc/boot/images/ramdisk.image.gz.  Then do a
'make zImage.initrd'.  That will deposit a zImage+initrd image into
arch/ppc/boot/images/.

If you have a U-boot port to your board then you can be a lot more
flexible since it can load a kernel image and ramdisk separately.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
