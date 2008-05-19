Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A73A3DE1C9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 04:20:48 +1000 (EST)
Message-ID: <4831C4F0.6060000@freescale.com>
Date: Mon, 19 May 2008 13:20:32 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org
Subject: Re: [PATCH] CS4270 node is misplaced in the MPC8610 device tree
References: <1210804193-8908-1-git-send-email-timur@freescale.com>
In-Reply-To: <1210804193-8908-1-git-send-email-timur@freescale.com>
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
> The CS4270 is using the second I2C bus, not the first, on the Freescale
> MPC8610 HPCD, so its node in the device tree belongs under 'i2c@3100'
> and not 'i2c@3000'.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Please disregard this patch.  It turns out that that both I2C controllers are
connected to the same bus, so it technically doesn't matter which node a device
is a child of.  However, tests show that sometimes one parent works, and
sometimes the other parent works.

-- 
Timur Tabi
Linux kernel developer at Freescale
