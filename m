Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D090DDEE7
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 02:11:25 +1000 (EST)
Message-ID: <4829BDE1.8000601@freescale.com>
Date: Tue, 13 May 2008 11:12:17 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [WATCHDOG] mpc8xxx_wdt: add support for MPC8xx watchdogs
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
	<8C355C2C-C029-4F02-A5B0-DA8173FAFF69@kernel.crashing.org>
	<20080513155507.GA25624@polina.dev.rtsoft.ru>
In-Reply-To: <20080513155507.GA25624@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
>  config 8xxx_WDT
>  	tristate "MPC8xxx Watchdog Timer"
> -	depends on PPC_83xx || PPC_86xx
> +	depends on FSL_SOC

We should probably change the description to "MPC8xxx Platform Watchdog 
Timer", and have help text indicating that it's not the Book-E core 
watchdog, and that it works on 8xx despite the discrepancy in the number 
of "x"s.

-Scott
