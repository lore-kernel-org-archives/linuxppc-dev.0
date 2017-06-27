Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxxCs4DpDzDr3V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 05:42:48 +1000 (AEST)
Date: Tue, 27 Jun 2017 15:42:42 -0400 (EDT)
Message-Id: <20170627.154242.1682587691752013432.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, geert@linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fsl/fman: add dependency on HAS_DMA
From: David Miller <davem@davemloft.net>
In-Reply-To: <1498492020-17623-1-git-send-email-madalin.bucur@nxp.com>
References: <1498492020-17623-1-git-send-email-madalin.bucur@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Mon, 26 Jun 2017 18:47:00 +0300

> A previous commit (5567e989198b5a8d) inserted a dependency on DMA
> API that requires HAS_DMA to be added in Kconfig.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>

Applied, thank you.
