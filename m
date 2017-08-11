Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTdf13j0hzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 07:37:58 +1000 (AEST)
Date: Fri, 11 Aug 2017 14:37:55 -0700 (PDT)
Message-Id: <20170811.143755.1486109421287401840.davem@davemloft.net>
To: florinel.iordache@nxp.com
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] fsl/fman: implement several errata workarounds
From: David Miller <davem@davemloft.net>
In-Reply-To: <1502372824-30180-1-git-send-email-florinel.iordache@nxp.com>
References: <1502372824-30180-1-git-send-email-florinel.iordache@nxp.com>
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

From: Florinel Iordache <florinel.iordache@nxp.com>
Date: Thu, 10 Aug 2017 16:47:04 +0300

> Implemented workarounds for the following dTSEC Erratum:
> A002, A004, A0012, A0014, A004839 on several operations
> that involve MAC CFG register changes: adjust link,
> rx pause frames, modify MAC address.
> 
> Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>

Applied, thanks.
