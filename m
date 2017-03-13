Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vhS132c1vzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 17:01:25 +1100 (AEDT)
Date: Sun, 12 Mar 2017 23:01:19 -0700 (PDT)
Message-Id: <20170312.230119.474358640757779704.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, camelia.groza@nxp.com,
 dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next v2 00/10] QorIQ DPAA 1 updates
From: David Miller <davem@davemloft.net>
In-Reply-To: <1489070225-7891-1-git-send-email-madalin.bucur@nxp.com>
References: <1489070225-7891-1-git-send-email-madalin.bucur@nxp.com>
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
Date: Thu, 9 Mar 2017 16:36:55 +0200

> This patch set introduces a series of fixes and features to the DPAA 1
> drivers. Besides activating hardware Rx checksum offloading, four traffic
> classes are added for Tx traffic prioritisation.
> 
> The changes are also available on the dpaa_eth-next branch in the git
> repository at:
> 
>   git://git.freescale.com/ppc/upstream/linux.git
> 
> changes from v1: added patch to enable context-A stashing

Pulled, thanks.
