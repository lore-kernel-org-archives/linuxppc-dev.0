Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4009DE078
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 07:01:15 +1000 (EST)
Message-ID: <4828B012.9090805@freescale.com>
Date: Mon, 12 May 2008 16:01:06 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>	<64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
	<20080512205303.GA14198@zarina> <4828AFBD.1040501@freescale.com>
In-Reply-To: <4828AFBD.1040501@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> It avoids confusion.  I vote for renaming.

Me too.  How about fsl_wdt.c?

Or we could come up with a name for that particular WDT device, like we 
did with the 85xx DMA controller.
