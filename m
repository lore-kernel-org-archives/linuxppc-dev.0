Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5C1B3B6FE2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 06:33:38 +1100 (EST)
Subject: Re: [PATCH] powerpc/dts: Removed fsl,msi property from dts.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1328794860-12592-1-git-send-email-diana.craciun@freescale.com>
Date: Fri, 16 Mar 2012 14:33:31 -0500
Message-Id: <36B1F034-98A1-4571-8B94-A01D345935DF@kernel.crashing.org>
References: <1328794860-12592-1-git-send-email-diana.craciun@freescale.com>
To: Diana Craciun <diana.craciun@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 9, 2012, at 7:41 AM, Diana Craciun wrote:

> From: Diana CRACIUN <Diana.Craciun@freescale.com>
> 
> The association in the decice tree between PCI and MSI
> using fsl,msi property was an artificial one and it does
> not reflect the actual hardware.
> 
> Signed-off-by: Diana CRACIUN <Diana.Craciun@freescale.com>
> ---
> arch/powerpc/boot/dts/p2041rdb.dts |    3 ---
> arch/powerpc/boot/dts/p3041ds.dts  |    4 ----
> arch/powerpc/boot/dts/p3060qds.dts |    2 --
> arch/powerpc/boot/dts/p4080ds.dts  |    3 ---
> arch/powerpc/boot/dts/p5020ds.dts  |    4 ----
> 5 files changed, 0 insertions(+), 16 deletions(-)

Should we not also remove the code associated with this property?

- k
