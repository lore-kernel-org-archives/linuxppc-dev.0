Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401dhY3fF7zDr2X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 04:17:47 +1100 (AEDT)
Date: Wed, 14 Mar 2018 13:17:41 -0400 (EDT)
Message-Id: <20180314.131741.1258816057122849215.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 camelia.groza@nxp.com, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] DPAA Ethernet fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
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
Date: Wed, 14 Mar 2018 08:37:27 -0500

> This patch set is addressing several issues in the DPAA Ethernet
> driver suite:
> 
>  - module unload crash caused by wrong reference to device being left
>    in the cleanup code after the DSA related changes
>  - scheduling wile atomic bug in QMan code revealed during dpaa_eth
>    module unload
>  - a couple of error counter fixes, a duplicated init in dpaa_eth.

Series applied, thank you.
