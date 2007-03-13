Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id D55D0DDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 02:28:28 +1100 (EST)
Date: Tue, 13 Mar 2007 09:28:20 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070313152820.GA3546@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:42:04PM -0600, Scott Wood wrote:
> +config CUIMAGE_DTS
> +	string "Device tree source file"
> +	depends on DEFAULT_UIMAGE
> +	help
> +	  This specifies the device tree source (.dts) file to be
> +	  compiled and included when building the cuImage target.  If a
> +	  relative filename is given, then it will be relative to
> +	  arch/powerpc/boot/dts.
> +
> +	  The cuImage target is used for booting on older U-Boot (and
> +	  PPCBoot) bootloaders that pass a bd_t instead of a device tree.
> +	  Such a kernel will not work with a newer U-Boot that passes the
> +	  device tree itself.  If your U-Boot does not mention a device
> +	  tree in "help bootm", then use the uImage target instead of
> +	  cuImage.

Oops, this should say, 'If your U-Boot does not mention a device tree in
"help bootm", then use the cuImage target.  Otherwise, use uImage.'

-Scott
