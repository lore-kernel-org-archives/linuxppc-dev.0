Return-Path: <neko@genesi-usa.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id CE80EDE0DF
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jan 2009 17:42:30 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d14so798654and.39
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 22:42:28 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <497C09D9.50004@genesi-usa.com>
Date: Sun, 25 Jan 2009 00:42:33 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 10/10] mmc: Add OpenFirmware bindings for SDHCI driver
References: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
	<20090122020041.GJ11492@oksana.dev.rtsoft.ru>
In-Reply-To: <20090122020041.GJ11492@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linuxppc-dev@ozlabs.org, Xie Xiaobo <X.Xie@freescale.com>,
	sdhci-devel@list.drzeus.cx, Pierre Ossman <drzeus-sdhci@drzeus.cx>,
	Konjin Lai <Konjin.Lai@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
>  
>  	  If unsure, say Y.
>  
> +config MMC_SDHCI_OF
> +	tristate "SDHCI support on OpenFirmware platforms"
> +	depends on MMC_SDHCI && PPC_OF
> +	help
> +	  This selects the OF Secure Digital Host Controller Interface.
> +	  So far there is only Freescale eSDHC controller known to exists
> +	  on OF platforms.

Nit; would probably be better English as

	This selects the OF support for Secure Digital Host Controller
	Interfaces. So far, only the Freescale eSDHC controller is known
	to exist on OF platforms.

-- Matt Sealey <matt@genesi-usa.com>
