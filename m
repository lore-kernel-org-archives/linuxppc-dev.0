Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0134.outbound.protection.outlook.com [157.56.111.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416D61A0D94
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 16:22:23 +1100 (AEDT)
Date: Thu, 29 Jan 2015 23:22:08 -0600
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Subject: Re: [v4] QE: Move QE from arch/powerpc to drivers/soc
Message-ID: <20150130052208.GA14431@home.buserror.net>
References: <1415763613-43674-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1415763613-43674-1-git-send-email-B45475@freescale.com>
Cc: netdev@vger.kernel.org, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 12, 2014 at 11:40:13AM +0800, Zhao Qiang wrote:
> ls1 has qe and ls1 has arm cpu.
> move qe from arch/powerpc to drivers/soc/fsl
> to adapt to powerpc and arm
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- move code to driver/soc
> Changes for v3:
> 	- change drivers/soc/qe to drivers/soc/fsl-qe
> Changes for v4:
> 	- move drivers/soc/fsl-qe to drivers/soc/fsl/qe
> 	- move head files for qe from include/linux/fsl to include/soc/fsl
> 	- move qe_ic.c to drivers/irqchip/

Need MAINTAINERS update for drivers/soc/fsl/qe, as previously discussed.

-Scott
