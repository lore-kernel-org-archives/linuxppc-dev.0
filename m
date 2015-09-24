Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0116.outbound.protection.outlook.com [65.55.169.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B85C21A0329
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 05:30:22 +1000 (AEST)
Message-ID: <1443123009.32298.29.camel@freescale.com>
Subject: Re: [PATCH v3 1/2] fsl: Add binding for RCPM
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
CC: <robh+dt@kernel.org>, <shawnguo@kernel.org>, <jason.jin@freescale.com>,
 <alison.wang@freescale.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
 Chenhui Zhao <chenhui.zhao@freescale.com>, Tang Yuantian
 <Yuantian.Tang@freescale.com>
Date: Thu, 24 Sep 2015 14:30:09 -0500
In-Reply-To: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
References: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
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

On Thu, 2015-09-24 at 16:29 +0800, Dongsheng Wang wrote:
> +* Freescale RCPM Wakeup Source Device Tree Bindings
> +-------------------------------------------
> +Required rcpm-wakeup property should be added to a device node if the 
> device
> +can be used as a wakeup source.
> +
> +  - rcpm-wakeup: The value of the property consists of cells, the number of
> +     cells defined in "fsl,#rcpm-wakeup-cells". The first cell is a pointer
> +     to the rcpm node, the second cell is the bit mask that should be set
> +     in IPPDEXPCR0, and the third cell is for IPPDEXPCR1, and so on.

The phandle should not be included in the cell count.

-Scott
