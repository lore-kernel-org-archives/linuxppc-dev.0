Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B0420DDFE5
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 16:55:14 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4V6t970010281
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:55:09 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4V6t8Wv019542
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 01:55:08 -0500 (CDT)
Subject: Re: [PATCH 2/3] Export of_bus_pci_get_flags().
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1180462985.13106.63.camel@ld0161-tx32>
References: <1180462985.13106.63.camel@ld0161-tx32>
Content-Type: text/plain
Message-Id: <1180594477.16792.4.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 31 May 2007 14:54:37 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-05-30 at 02:23, Jon Loeliger wrote:
> From: Jon Loeliger <jdl@freescale.com>
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>  arch/powerpc/kernel/prom_parse.c |    2 +-
>  include/asm-powerpc/prom.h       |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)

Acked-by: Roy Zang <tie-fei.zang@freescale.com>
