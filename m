Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1D9F467B32
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 02:12:01 +1000 (EST)
Subject: Re: How to move from /ppc/ to /powerpc/
From: Jon Loeliger <jdl@freescale.com>
To: Fredrik Roubert <roubert@df.lth.se>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20060912105830.3923d537.kim.phillips@freescale.com>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
Content-Type: text/plain
Message-Id: <1158077030.27129.189.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 12 Sep 2006 11:03:50 -0500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-12 at 10:58, Kim Phillips wrote:

> > I boot the board with U-Boot (version 1.1.4, customized), and I assume
> > that I need to add some stuff for this new device tree thing, but I
> > can't figure out exactly what the kernel will expect.
> 
> the kernel expects a pointer to a device tree instead of a bd_t.
> The 8349EMDS device tree source is now in linux/arch/powerpc/boot/dts.
> You'll need the device tree compiler (dtc) from jdl.com to build
> your flat device tree binary (dtb; what the kernel expects).

And you should read:

    linux-2.6/Documentation/powerpc/booting-without-of.txt

jdl
