Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tv0BF52grzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 05:45:41 +1100 (AEDT)
Date: Wed, 04 Jan 2017 13:45:28 -0500 (EST)
Message-Id: <20170104.134528.1077940126567605741.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dpaa_eth: a couple of fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <1483528890-8621-1-git-send-email-madalin.bucur@nxp.com>
References: <1483528890-8621-1-git-send-email-madalin.bucur@nxp.com>
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
Date: Wed, 4 Jan 2017 13:21:28 +0200

> Add cleanup on PHY initialization failure path, avoid using
> uninitialized memory at CGR init.

Series applied, thanks.
