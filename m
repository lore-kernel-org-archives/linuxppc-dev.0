Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0141.outbound.protection.outlook.com [157.56.110.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28BFF1A041B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 09:56:51 +1000 (AEST)
Message-ID: <1442361398.2909.164.camel@freescale.com>
Subject: Re: [PATCH v2 1/2] fsl: Add binding for RCPM
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <alison.wang@freescale.com>, <jason.jin@freescale.com>, Chenhui Zhao
 <chenhui.zhao@freescale.com>, Tang Yuantian <Yuantian.Tang@freescale.com>
Date: Tue, 15 Sep 2015 18:56:38 -0500
In-Reply-To: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
References: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
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

On Tue, 2015-09-15 at 16:55 +0800, Dongsheng Wang wrote:
> +* Freescale RCPM Wakeup Source Device Tree Bindings
> +-------------------------------------------
> +Required rcpm-wakeup property should be added to a device node if the 
> device
> +can be used as a wakeup source.
> +
> +  - rcpm-wakeup: The value of the property consists of 3 cells. The first 
> cell
> +     is a pointer to the rcpm node, the second cell is the bit mask that
> +     should be set in IPPDEXPCR0, and the last cell is for IPPDEXPCR1.
> +     Note: If the platform has no IPPDEXPCR1 register, put a zero here.

What if a future platform has more than two of these registers?

-Scott
