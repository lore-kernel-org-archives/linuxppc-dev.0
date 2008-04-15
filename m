Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A3F7DEC4B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 06:07:03 +1000 (EST)
Message-Id: <C0289853-A524-443E-B25D-7A6A4C5E20CC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080415160338.GA2705@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] mpc8313erdb: Update defconfig,
	enabling FCM NAND and OF partitions
Date: Tue, 15 Apr 2008 15:06:50 -0500
References: <20080415160338.GA2705@loki.buserror.net>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Kim Phillips <Kim.Phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 11:03 AM, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/configs/mpc8313_rdb_defconfig |    8 +++++---
> 1 files changed, 5 insertions(+), 3 deletions(-)

Do we want similar updates to the mpc83xx_defconfig?

- k
