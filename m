Return-Path: <wim@iguana.be>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by ozlabs.org (Postfix) with ESMTP id C5F33DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 04:35:49 +1100 (EST)
Date: Wed, 18 Mar 2009 18:35:47 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v3 1/2] powerpc/86xx: Board support for GE Fanuc's PPC9A
Message-ID: <20090318173547.GF7571@infomag.iguana.be>
References: <20090318122501.25609.11105.stgit@ubuntu8041.localdomain>
	<20090318122914.25609.765.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090318122914.25609.765.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, wim@iguana.be, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Martyn,

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c7352f7..ecf52e4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -772,7 +772,7 @@ config TXX9_WDT
>  
>  config GEF_WDT
>  	tristate "GE Fanuc Watchdog Timer"
> -	depends on GEF_SBC610 || GEF_SBC310
> +	depends on GEF_SBC610 || GEF_SBC310 || GEF_PPC9A
>  	---help---
>  	  Watchdog timer found in a number of GE Fanuc single board computers.

This part is Signed-off-by me. The rest I leave up to the powerpc maintainers.

Kind regards,
Wim.
