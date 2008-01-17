Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 331EDDDEBA
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 09:07:23 +1100 (EST)
Message-ID: <478FD1A4.5080005@freescale.com>
Date: Thu, 17 Jan 2008 16:07:32 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 2/7] powerpc: allow localbus compatible serial ports	for
	console device
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>	<200801071533.47018.arnd@arndb.de>
	<47824641.8090208@windriver.com>	<200801071704.23151.arnd@arndb.de>
	<20080117220357.GC4122@windriver.com>
In-Reply-To: <20080117220357.GC4122@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Gortmaker wrote:
> +static struct __init serial_parent parents[] = {
> +	{"soc", NULL},
> +	{"tsi-bridge", NULL},
> +	{"opb", "ibm,opb"},
> +	{NULL, "wrs,epld-localbus"},
> +};

can we add {NULL, "simple-bus"} to this list?

-Scott
