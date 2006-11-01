Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 06B0967B89
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 06:55:53 +1100 (EST)
Subject: Re: [RFC] Current Lite5200b patchset
From: Jon Loeliger <jdl@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <11623703962380-git-send-email-grant.likely@secretlab.ca>
References: <11623703962380-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain
Message-Id: <1162410451.26073.42.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 01 Nov 2006 13:47:31 -0600
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-01 at 02:39, Grant Likely wrote:

> You'll also need to get the lite5200 device tree patch for u-boot off the
> u-boot-users mailing list, and the device tree compiler from www.jdl.com.
> 
> Device tree is compiled w/:
> $ dtc -V 0x10 -f -O dtb arch/powerpc/boot/dts/lite5200b.dts > lite5200b.dtb

And note that I just made -V 0x10 the default!

jdl
