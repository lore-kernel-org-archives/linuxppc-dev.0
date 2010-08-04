Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3645B6F14
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 05:15:55 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc/85xx: Fix SWIOTLB initalization for
	MPC85xxMDS boards
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100608195540.GA11446@oksana.dev.rtsoft.ru>
Date: Wed, 4 Aug 2010 14:15:46 -0500
Message-Id: <52E24FDC-C049-4E7F-BE8D-9127D079DE6D@kernel.crashing.org>
References: <20100608195540.GA11446@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 8, 2010, at 2:55 PM, Anton Vorontsov wrote:

> The code inside '#ifdef CONFIG_QUICC_ENGINE' makes the
> mpc85xx_mds_setup_arch() return early if no QE nodes present,
> and so SWIOTLB is never initialized.
> 
> This patch fixes the issue by moving SWIOTLB code above
> QE.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |   16 ++++++++--------
> 1 files changed, 8 insertions(+), 8 deletions(-)

applied to next

- k
