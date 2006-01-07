Return-Path: <grant.likely@secretlab.ca>
Message-ID: <43BF5302.4030602@secretlab.ca>
Date: Fri, 06 Jan 2006 22:34:58 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@comcast.net>
References: <20060106221601.78327.qmail@web33515.mail.mud.yahoo.com>
	<43BF4AB8.6030003@comcast.net>
In-Reply-To: <43BF4AB8.6030003@comcast.net>
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
> 	initramfs does nto exist in 2.4, but despite a dearth of information it
> works extremely well in 2.6.
> 
> 	Set CONFIG_INITRAMFS=path to directory tree to build into ramdisk, and
> the kernel building process will take care of most evrything else.
> Unlike initrd, there are not two separate files, that each have to be
> loaded. The initial ramdisk is part of the kernel image, gets
> uncompressed by the kernel, and is just generally painless - except for
> the scarcity of documentation.
So... have are been able to use initramfs as a drop in replacement for
initrd, or did you have to jump through extra hoops?  I attempted to use
initramfs a few months ago, but wasn't ever able to get it to run init.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
