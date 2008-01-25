Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F079EDE066
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:10 +1100 (EST)
Date: Fri, 25 Jan 2008 15:23:04 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 4/9] enable FSL SATA driver config for Freescale SoCs
In-Reply-To: <20080124204621.2c09359e.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0801251522160.20972@blarg.am.freescale.net>
References: <20080124204621.2c09359e.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jeff@garzik.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 24 Jan 2008, Kim Phillips wrote:

> The mpc8315 shares the same SATA controller as the mpc837x,
> and likelihood is that future SoCs from Freescale will also.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> Kumar, let me know if you want me to post this to the ata list (I'm
> assuming it's not necessary).
>
>  drivers/ata/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>

applied.

- k
