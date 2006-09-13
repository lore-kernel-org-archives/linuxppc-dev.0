Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 70E2167B5C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 00:54:39 +1000 (EST)
Subject: Re: How to move from /ppc/ to /powerpc/
From: Jon Loeliger <jdl@freescale.com>
To: Fredrik Roubert <roubert@df.lth.se>
In-Reply-To: <20060913132817.GD18263@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
Content-Type: text/plain
Message-Id: <1158158776.27129.232.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 13 Sep 2006 09:46:17 -0500
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

On Wed, 2006-09-13 at 08:28, Fredrik Roubert wrote:
> On Tue 12 Sep 17:58 CEST 2006, Kim Phillips wrote:
> 
> > The 8349EMDS device tree source is now in linux/arch/powerpc/boot/dts.
> 
> Is that the right dts to use for a MPC8349SYS board?
> 
> I tried compiling it like this:
> 
> $ dtc -f -I dts -O dtb mpc8349emds.dts > devices.dtb
> DTC: dts->dtb  on file "mpc8349emds.dts"
> Warning: No cpu has "linux,boot-cpu" property
> ERROR: Missing /chosen node
> Input tree has errors
> 
> Is that really correct? Should I invoke dtc in some other way or modify
> the dts or use some other dts file?

You must use the -V 16 flag too.  Likely, -b 0 as well.

jdl
