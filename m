Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28423DF2D8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 03:00:10 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m7LGiPm1029289
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 10:00:05 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7LGF5hf022956
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 11:15:05 -0500 (CDT)
Date: Thu, 21 Aug 2008 11:15:05 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: boot cuImage on an old u-boot
Message-ID: <20080821161505.GA15669@ld0162-tx32.am.freescale.net>
References: <20080820150958.GA23294@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080820150958.GA23294@Chamillionaire.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 20, 2008 at 05:09:58PM +0200, Sebastian Siewior wrote:
> I have here a mpc8540ads board and a u-boot 1.0.0. I've build the
> defconfig for the board and I tried to boot the genarated
> cuImage.mpc8540ads image. After the bootm command I see just
> 
> |8540> bootm 1000000
> |## Booting image at 01000000 ...
> |   Image Name:   Linux-2.6.26
> |   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> |   Data Size:    1232711 Bytes =  1.2 MB
> |   Load Address: 00400000
> |   Entry Point:  004005ac
> |   Verifying Checksum ... OK
> |   Uncompressing Kernel Image ... OK
> |
> 
> I don't see the device tree fixups printfs, so crash happend quite
> early. Anyone an idea what I could have done wrong?

Make sure the device tree contains /chosen/linux,stdout-path.

-Scott
