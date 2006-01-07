Return-Path: <dhlii@comcast.net>
Message-ID: <43BF4AB8.6030003@comcast.net>
Date: Fri, 06 Jan 2006 23:59:36 -0500
From: "David H. Lynch Jr." <dhlii@comcast.net>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
References: <20060106221601.78327.qmail@web33515.mail.mud.yahoo.com>
In-Reply-To: <20060106221601.78327.qmail@web33515.mail.mud.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
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


	initramfs does nto exist in 2.4, but despite a dearth of information it
works extremely well in 2.6.

	Set CONFIG_INITRAMFS=path to directory tree to build into ramdisk, and
the kernel building process will take care of most evrything else.
Unlike initrd, there are not two separate files, that each have to be
loaded. The initial ramdisk is part of the kernel image, gets
uncompressed by the kernel, and is just generally painless - except for
the scarcity of documentation.
