Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0132.outbound.protection.outlook.com [157.56.110.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEBB61A0BD7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 02:29:45 +1000 (AEST)
Message-ID: <1437755369.2993.243.camel@freescale.com>
Subject: Re: [PATCH] powerpc/p1010rdb:update dts for pcie interrupt-map
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <robh+dt@kernel.org>, <devicetree@vger.kernel.org>, Zhao Qiang
 <B45475@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 24 Jul 2015 11:29:29 -0500
In-Reply-To: <1437377539-15911-1-git-send-email-qiang.zhao@freescale.com>
References: <1437377539-15911-1-git-send-email-qiang.zhao@freescale.com>
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

On Mon, 2015-07-20 at 15:32 +0800, Zhao Qiang wrote:
> From: Zhao Qiang <B45475@freescale.com>
> 
> p1010rdb-pb use the irq[4:5] for inta and intb to pcie,
> it is active-high, so set it.

What about revisions of p1010rdb other than pb?

> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> Change-Id: I29db41b4a8b5a67c18151099884edda6de4d9d1a
> Reviewed-on: http://git.am.freescale.net:8181/9915
> Tested-by: Review Code-CDREVIEW <CDREVIEW@freescale.com>
> Reviewed-by: Xiaobo Xie <X.Xie@freescale.com>
> Reviewed-by: Jose Rivera <German.Rivera@freescale.com>

Get rid of the gerrit crud.

-Scott
