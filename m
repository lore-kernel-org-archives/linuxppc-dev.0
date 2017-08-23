Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcZdv55svzDqh4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 14:46:48 +1000 (AEST)
Date: Tue, 22 Aug 2017 21:46:45 -0700 (PDT)
Message-Id: <20170822.214645.953115103494976385.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] fsl/fman: enable FMan Keygen
From: David Miller <davem@davemloft.net>
In-Reply-To: <AM5PR0402MB2691CF2AC9555829EC89C59CEC850@AM5PR0402MB2691.eurprd04.prod.outlook.com>
References: <1503423066-15420-2-git-send-email-madalin.bucur@nxp.com>
 <20170822.143510.1048652578169181274.davem@davemloft.net>
 <AM5PR0402MB2691CF2AC9555829EC89C59CEC850@AM5PR0402MB2691.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
Date: Wed, 23 Aug 2017 04:36:56 +0000

> The struct fman is only visible in the fman file, the fman port
> module uses struct fman as an opaque pointer, thus this export.

Don't use that programming model.

Export the datastructure properly to it's users.

This abstraction scheme is so wasteful and costly.
