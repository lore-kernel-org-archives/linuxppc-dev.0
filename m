Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPBpl1r2kzDw03
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 06:14:22 +1100 (AEDT)
Message-ID: <1479928449.21746.53.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Jun Yang <jun.yang@nxp.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 23 Nov 2016 13:14:09 -0600
In-Reply-To: <VI1PR0401MB20628C7AC37B0187C721F10F9DB40@VI1PR0401MB2062.eurprd04.prod.outlook.com>
References: <1477500644-31812-1-git-send-email-jun.yang@nxp.com>
 <20161122074126.GA15587@home.buserror.net>
 <VI1PR0401MB20628C7AC37B0187C721F10F9DB40@VI1PR0401MB2062.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: fsl_pamu: erratum a007907 should be applied on all versions of
 E6500 chips.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-22 at 08:43 +0000, Jun Yang wrote:
> Hello Scott,
> Do you know the IOMMU maintainer's mail address?

>From MAINTAINERS:

IOMMU DRIVERS
M:      Joerg Roedel <joro@8bytes.org>
L:      iommu@lists.linux-foundation.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
S:      Maintained
F:      Documentation/devicetree/bindings/iommu/
F:      drivers/iommu/

Also CC Varun Sethi <Varun.Sethi@freescale.com>

-Scott
