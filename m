Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0115.outbound.protection.outlook.com [157.56.110.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F41451A029E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 08:16:32 +1100 (AEDT)
Message-ID: <1450905374.18314.112.camel@freescale.com>
Subject: Re: [v2] powerpc/mpc85xx: Add pcsphy nodes to FManV3 device tree
From: Scott Wood <scottwood@freescale.com>
To: <igal.liberman@freescale.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <madalin.bucur@freescale.com>, <shaohui.xie@freescale.com>
Date: Wed, 23 Dec 2015 15:16:14 -0600
In-Reply-To: <1450758333-14255-1-git-send-email-igal.liberman@freescale.com>
References: <1450758333-14255-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-12-22 at 06:25 +0200, igal.liberman@freescale.com wrote:
> From: Igal Liberman <igal.liberman@freescale.com>
> 
> Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> 
> This patch adds pcsphy node to FManV3 device tree.
> Based on: https://patchwork.ozlabs.org/patch/503921/
> 
> v1 --> v2:
> 	- Addressed feedback from Shaohui Xie
> 	- Submitted a binding document:
> 	  https://patchwork.ozlabs.org/patch/560134/
> 	
> ---

Everything above starting with "Based on" should go below the --- line.

-Scott
