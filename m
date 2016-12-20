Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tjnDy0r6yzDwWF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 06:01:05 +1100 (AEDT)
Date: Tue, 20 Dec 2016 14:00:53 -0500 (EST)
Message-Id: <20161220.140053.624816790746806575.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scott.wood@nxp.com, mpe@ellerman.id.au
Subject: Re: [PATCH net v4 0/4] fsl/fman: fixes for ARM
From: David Miller <davem@davemloft.net>
In-Reply-To: <1482180166-10677-1-git-send-email-madalin.bucur@nxp.com>
References: <1482180166-10677-1-git-send-email-madalin.bucur@nxp.com>
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
Date: Mon, 19 Dec 2016 22:42:42 +0200

> The patch set fixes advertised speeds for QSGMII interfaces, disables
> A007273 erratum workaround on non-PowerPC platforms where it does not
> apply, enables compilation on ARM64 and addresses a probing issue on
> non PPC platforms.
> 
> Changes from v3: removed redundant comment, added ack by Scott
> Changes from v2: merged fsl/fman changes to avoid a point of failure
> Changes from v1: unifying probing on all supported platforms

Series applied, thanks.
