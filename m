Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 076E667B91
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 10:54:45 +1100 (EST)
Date: Fri, 10 Feb 2006 17:46:10 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: atul.sabharwal@exgate.tek.com
Subject: RE: kernel startup
In-Reply-To: <4A062D477D842B4C8FC48EA5AF2D41F201BA207A@us-bv-m23.global.tektronix.net>
Message-ID: <Pine.LNX.4.44.0602101745150.31619-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Normally is it the uboot that uncompresses the kernel or the kernel
> uncompress itself? 
> 
> >>How would something compressed uncompress itself?  If u-boot is being
> used 
> >>it will uncompress a compressed kernel and put the image at physical
> 0.
> 
> Small correction. Just like a self extracting binary, a kernel can have
> a decompression code prepended to the start of kernel which can
> decompress the 
> Kernel.  This is how redboot for xscale is structured or syslinux /lilo
> for x86. 

This also happens with the boot wrapper that is in arch/{ppc,powerpc}/boot

> 
> Although u-boot has simplified this step by doing the CRC checksum of
> the
> uiMage header as well as data and also decompress the kernel. Based on
> load
> address, entry point, the kernel can start executing.  
> 
> Now, whether cache is enable or not, MMU is enabled/disabled depends on
> the
> Developer. In current u-boot, the MMU is not used. I-Cache is On and
> D-cache
> is off.

I'm not sure what sub-arch we are talking about, but some do have the MMU 
on.

- kumar
