Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6BDADE0D5
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 06:42:06 +1000 (EST)
Message-ID: <487E5D14.6030609@freescale.com>
Date: Wed, 16 Jul 2008 15:41:56 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc: fix ALSA options in Freescale 85xx and 86xx
	defconfigs
References: <1214346902-4363-1-git-send-email-timur@freescale.com>
In-Reply-To: <1214346902-4363-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> The defconfigs for Freescale 85xx and 86xx SOCs had bad choices for some
> audio related options.  In particular, OSS emulation should be enabled,
> and the old ALSA API should be disabled.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

Kumar, can you apply this patch, please?

-- 
Timur Tabi
Linux kernel developer at Freescale
