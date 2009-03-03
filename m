Return-Path: <Guenter.Leonhardt@men.de>
Received: from mail193.messagelabs.com (mail193.messagelabs.com
	[85.158.140.195]) by ozlabs.org (Postfix) with SMTP id 56755DDF95
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 00:11:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: U-Boot image
Date: Tue, 3 Mar 2009 14:11:36 +0100
Message-ID: <D0B748CCD5DF144CA5C56A9D860A31341DE5C9@men-exch1.intra.men.de>
From: =?iso-8859-1?Q?G=FCnter_Leonhardt?= <Guenter.Leonhardt@men.de>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
I'am looking for an image to boot a embedded device with a single image.

I though the generated uImage in arch/powerpc/boot should work, but =
u-boot cannot but this,
because the addresses of initrd and dtb not found.

Now I'am creating the image by hand with mkimage:
mkimage -A ppc -n F302 -O linux \
		-T multi -C gzip -a 0x0 -e 0x0 \
            -d vmlinux.bin.gz:initramfs_data.cpio.gz:f302.dtb \
            uImage

This file is bootable, but I don't understand how a standard file has to =
be booted.

I read in th u-boot documentation about a new fileformat which is build =
with the dtc.

Can someone explain me the different fileforamts for booting a powerpc =
with u-boot?
Which is the simplest to use?

Shold I reconfigure u-boot?

Thanks for help
G=FCnter
