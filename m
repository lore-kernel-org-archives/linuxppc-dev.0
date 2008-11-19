Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26FEDDDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 07:52:21 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mAJKqHZE019856
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 13:52:17 -0700 (MST)
Message-Id: <0F5C398A-01A4-4BCB-BB68-C527DDBD1DDF@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1227120055-6459-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: L2 cache size wrong in 8572DS dts
Date: Wed, 19 Nov 2008 14:52:16 -0600
References: <1227120055-6459-1-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 19, 2008, at 12:40 PM, Trent Piepho wrote:

> It's 1MB, not 512KB.  Newer U-Boots will fix this entry, but that's no
> reason to have the wrong value in the dts.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/mpc8572ds.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to merge

- k
