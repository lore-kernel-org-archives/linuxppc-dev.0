Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydyKZ0DrGzDrRX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Nov 2017 12:37:48 +1100 (AEDT)
Date: Sat, 18 Nov 2017 10:37:41 +0900 (KST)
Message-Id: <20171118.103741.2188624322816899740.davem@davemloft.net>
To: desnesn@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tlfalcon@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com
Subject: Re: [PATCH] [net] ibmvnic: fix dma_mapping_error call
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171117110904.9797-1-desnesn@linux.vnet.ibm.com>
References: <20171117110904.9797-1-desnesn@linux.vnet.ibm.com>
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

From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
Date: Fri, 17 Nov 2017 09:09:04 -0200

> This patch fixes the dma_mapping_error call to use the correct dma_addr
> which is inside the ibmvnic_vpd struct. Moreover, it fixes an uninitialized
> warning regarding a local dma_addr variable which is not used anymore.
> 
> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of VPD for the ibmvnic driver")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>

Applied.
