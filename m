Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7FD31A08BB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 10:33:55 +1100 (AEDT)
Date: Fri, 16 Oct 2015 18:33:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Claudiu Manoil <claudiu.manoil@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>, "Zhao
 Chenhui" <chenhui.zhao@freescale.com>, "David S. Miller"
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>, <galak@codeaurora.org>
Subject: Re: [2/3] powerpc: dts: p1022si: Add fsl,wake-on-filer for eTSEC
Message-ID: <20151016233334.GA13511@home.buserror.net>
References: <1443694222-29519-1-git-send-email-claudiu.manoil@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1443694222-29519-1-git-send-email-claudiu.manoil@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2015 at 01:10:22PM +0300, Claudiu Manoil wrote:
> Enable the "wake-on-filer" (aka. wake on user defined packet)
> wake on lan capability for the eTSEC ethernet nodes.
> 
> Cc: Li Yang <leoli@freescale.com>
> Cc: Zhao Chenhui <chenhui.zhao@freescale.com>
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p1022si-post.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
