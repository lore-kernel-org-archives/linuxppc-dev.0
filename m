Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A553ADDEBA
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 06:35:59 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l72KZrNS014226
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 16:35:53 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l72KZrtg215198
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:35:53 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l72KZq70017199
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Aug 2007 14:35:52 -0600
Date: Thu, 2 Aug 2007 15:35:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 6/6] PowerPC 440EPx: Sequoia new EMAC support
Message-ID: <20070802153551.2a8ad14d@weaponx.rchland.ibm.com>
In-Reply-To: <20070730152339.GA5126@ru.mvista.com>
References: <20070730152339.GA5126@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 30 Jul 2007 19:23:39 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> The patch adds PHY support for the Sequoia board to the new EMAC driver and
> enables NEW_EMAC for 440EPx Kconfig.
> The phy code has been written by Stefan Roese.
> This has been tested with the following version of the EMAC dirver:
> 
> http://ozlabs.org/~dgibson/home/emac/powerpc-emac-new-20070516.patch
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/platforms/44x/Kconfig |    5 +---
>  drivers/net/ibm_newemac/phy.c      |   39 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 3 deletions(-)
> 
> --- linux.orig/arch/powerpc/platforms/44x/Kconfig	2007-07-30 15:05:50.000000000 +0400
> +++ linux/arch/powerpc/platforms/44x/Kconfig	2007-07-30 17:59:05.000000000 +0400
> @@ -47,9 +47,8 @@
>  config 440EPX
>  	bool
>  	select PPC_FPU
> -# Disabled until the new EMAC Driver is merged.
> -#	select IBM_NEW_EMAC_EMAC4
> -#	select IBM_NEW_EMAC_ZMII
> +	select IBM_NEW_EMAC_EMAC4
> +	select IBM_NEW_EMAC_ZMII

Probably don't want this bit yet.  The EMAC driver isn't really merged
yet.

josh
