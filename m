Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0C89DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2008 03:36:53 +1100 (EST)
Message-ID: <49131D15.5080001@freescale.com>
Date: Thu, 06 Nov 2008 10:36:37 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH V3] powerpc: Fix Book-E watchdog timer interval setting
References: <200811052153.57292.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200811052153.57292.matthias.fuchs@esd-electronics.com>
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

Matthias Fuchs wrote:
> This patch fixes the setting of the Book-E watchdog timer interval setup
> on initialization and by ioctl().
> 
> On initialization the period bits have to be masked before setting
> a new period.
> 
> In WDIOC_SETTIMEOUT ioctl we have to use the correct mask.
> 
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
