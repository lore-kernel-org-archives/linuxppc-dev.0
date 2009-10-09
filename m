Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB460B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Oct 2009 04:04:54 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n99H4ZgV004780 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 9 Oct 2009 10:04:46 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n99H7PAF024002
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 9 Oct 2009 12:07:25 -0500 (CDT)
Date: Fri, 9 Oct 2009 12:04:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Roberto Guerra <roberto.j.guerra@gmail.com>
Subject: Re: Support for S29JL064 in MPC8272ADS?
Message-ID: <20091009170433.GA17372@b07421-ec1.am.freescale.net>
References: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2009 at 10:14:56AM -0400, Roberto Guerra wrote:
> Hello,
> My uboot can read my flash chip, finding the uImage and the initramfs,
> and booting the kernel fine. However, I'd like the Linux kernel to
> read my flash chip so that it can update files in it.

Have you described your flash chip in the device tree?

> However, the kernel does not detect any flash chip (nor there's any
> indication that a CFI probe is being performed).

The stock device tree for mpc8272ads only specifies it as a JEDEC
flash, not CFI.

-Scott
