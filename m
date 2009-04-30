Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8B04DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 16:05:19 +1000 (EST)
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Feng Kan <fkan@amcc.com>
In-Reply-To: <1241041345-19479-1-git-send-email-fkan@amcc.com>
References: <1241041345-19479-1-git-send-email-fkan@amcc.com>
Content-Type: text/plain
Date: Thu, 30 Apr 2009 16:05:11 +1000
Message-Id: <1241071511.29501.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-29 at 14:42 -0700, Feng Kan wrote:
> Signed-off-by: Feng Kan <fkan@amcc.com>
> ---
>  drivers/ata/Kconfig    |   76 +-
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_dwc.c | 2047 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2091 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 0bcf264..5321e47 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -72,56 +72,66 @@ config SATA_FSL
>  
>  	  If unsure, say N.
>  
> -config ATA_SFF
> -	bool "ATA SFF support"
> -	default y

Hi Feng !

Nice to see this driver finally submitted !

However, it should be sent to the linux-ide mailing list in order to be
reviewed by the right people (though you should keep linuxppc-dev on
CC).

Also, I think you want to avoid that Kconfig churn, just add your option
as a drop-in, don't re-arrange half of the file while at it :-)

Cheers,
Ben.
