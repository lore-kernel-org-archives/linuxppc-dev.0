Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0145.outbound.protection.outlook.com [207.46.100.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E75721A0CE1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 11:54:21 +1100 (AEDT)
Message-ID: <1422579249.10544.140.camel@freescale.com>
Subject: Re: [PATCH][v4] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: <shh.xie@gmail.com>
Date: Thu, 29 Jan 2015 18:54:09 -0600
In-Reply-To: <1422446064-3901-1-git-send-email-shh.xie@gmail.com>
References: <1422446064-3901-1-git-send-email-shh.xie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-28 at 19:54 +0800, shh.xie@gmail.com wrote:
> +- interrupts
> +		Usage: required
> +		Value type: <prop-encoded-array>
> +		Definition: Event interrupt of external MDIO controller.

What if this MDIO controller is not "external"?  Should Usage say
"required for external MDIO"?

-Scott
