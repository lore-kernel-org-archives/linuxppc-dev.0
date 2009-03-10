Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C55E8DDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 01:43:40 +1100 (EST)
Message-Id: <287065E2-535B-44AA-BF4C-2D79FD1C7614@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1236695923-20119-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/85xx: Fix MPC8572DS PCI protected interrupt
	sources
Date: Tue, 10 Mar 2009 09:43:33 -0500
References: <1236695923-20119-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Ted Peters <ted.peters@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 10, 2009, at 9:38 AM, Kumar Gala wrote:

> From: Ted Peters <ted.peters@freescale.com>
>
> The PCI irqs for the protected sources where not correct for PCI PHBs
>
> Signed-off-by: Ted Peters <ted.peters@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    2 +-
> arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

applied to next

- k
