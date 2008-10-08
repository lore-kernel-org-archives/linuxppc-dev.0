Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 020A2DDF44
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 23:39:32 +1100 (EST)
Message-Id: <4800D7D4-28BC-435A-9858-8FAF41F38468@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <1223413998-15577-1-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/3] powerpc: 5121: Add PCI support.
Date: Wed, 8 Oct 2008 07:38:58 -0500
References: <1223413998-15577-1-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 7, 2008, at 4:13 PM, John Rigby wrote:

> Uses mpc83xx_add_bridge in fsl_pci.c
>
> Adds second register tuple to pci node register property
> as done for 83xx device trees in a previous patch.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc5121ads.dts      |    3 ++-
> arch/powerpc/platforms/512x/Kconfig       |    2 ++
> arch/powerpc/platforms/512x/mpc5121_ads.c |   10 ++++++++++
> arch/powerpc/sysdev/fsl_pci.c             |    4 ++--
> 4 files changed, 16 insertions(+), 3 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
