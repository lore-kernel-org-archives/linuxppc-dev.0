Return-Path: <grant.likely@secretlab.ca>
Message-ID: <43C2943F.4060605@secretlab.ca>
Date: Mon, 09 Jan 2006 09:50:07 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>
References: <20060106221601.78327.qmail@web33515.mail.mud.yahoo.com>
	<43BF4AB8.6030003@comcast.net> <43BF5302.4030602@secretlab.ca>
	<43C027B0.2070409@dlasys.net>
In-Reply-To: <43C027B0.2070409@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Booting from RAM Disk
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
> Grant Likely wrote:
> 
> 	I have never tried to build an initrd system.

rolling up an initrd & kernel is actually very simple; but I had to read
the Makefile to figure out how to do it!  I do it by copying
ramdisk.image.gz into arch/ppc/boot/images and building 'make
zImage.initrd'.

> 
> 	I like initramfs - the only problem I had putting it together was
> finding the information to do it.
> 
> 	In the instance of the E12 I needed something that was wrapped into a
> single file with the kernl. The E12 already had an elf loader, but all
> it did was load elf files. It did not handle ramdisk other images etc.
> INITRAMFS provided a means to start on the E12 without having to write
> another loader.

So... how do you build the initramfs?

I'd prefer to use initramfs; I just haven't had a whole lot of luck with
it and other concerns took my focus.  :/

Thanks,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
