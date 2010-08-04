Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FE24B70A4
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:18:23 +1000 (EST)
Subject: Re: [PATCH 1/2] fsl_pci: add quirk for mpc8308 pcie bridge
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1278619839-23998-2-git-send-email-yanok@emcraft.com>
Date: Wed, 4 Aug 2010 14:18:08 -0500
Message-Id: <70F43DAD-E443-44D4-9F21-E036D439A6A4@kernel.crashing.org>
References: <1278619839-23998-1-git-send-email-yanok@emcraft.com>
	<1278619839-23998-2-git-send-email-yanok@emcraft.com>
To: Ilya Yanok <yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2010, at 3:10 PM, Ilya Yanok wrote:

> This patch adds the quirk for PCIE controller found on Freescale MPC8308.
> The quirk is the same as for other MPC83xx processors.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |    1 +
> include/linux/pci_ids.h       |    1 +
> 2 files changed, 2 insertions(+), 0 deletions(-)

applied to next

- k
