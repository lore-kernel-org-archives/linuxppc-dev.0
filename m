Return-Path: <dhlii@dlasys.net>
Message-ID: <43C027B0.2070409@dlasys.net>
Date: Sat, 07 Jan 2006 15:42:24 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
References: <20060106221601.78327.qmail@web33515.mail.mud.yahoo.com>
	<43BF4AB8.6030003@comcast.net> <43BF5302.4030602@secretlab.ca>
In-Reply-To: <43BF5302.4030602@secretlab.ca>
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

Grant Likely wrote:
> David H. Lynch Jr. wrote:
> 
>>	initramfs does nto exist in 2.4, but despite a dearth of information it
>>works extremely well in 2.6.
>>
>>	Set CONFIG_INITRAMFS=path to directory tree to build into ramdisk, and
>>the kernel building process will take care of most evrything else.
>>Unlike initrd, there are not two separate files, that each have to be
>>loaded. The initial ramdisk is part of the kernel image, gets
>>uncompressed by the kernel, and is just generally painless - except for
>>the scarcity of documentation.
> 
> So... have are been able to use initramfs as a drop in replacement for
> initrd, or did you have to jump through extra hoops?  I attempted to use
> initramfs a few months ago, but wasn't ever able to get it to run init.
> 
> g.
> 

	I can't exactly answer that - While I have used both, The only one I
have actually tried to put onto an embedded system is initramfs.

	I normallly use Debian which puts together an initrd for you fairly easily.
	I used Gentoo on a few systems and it uses initramfs - but it seems to
use it in an odd configuration similair to initrd, where the Ramdisk
image is a separate file.

	I have never tried to build an initrd system.

	I like initramfs - the only problem I had putting it together was
finding the information to do it.

	In the instance of the E12 I needed something that was wrapped into a
single file with the kernl. The E12 already had an elf loader, but all
it did was load elf files. It did not handle ramdisk other images etc.
INITRAMFS provided a means to start on the E12 without having to write
another loader.
