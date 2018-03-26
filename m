Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408blP26cczF1sZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:14:24 +1100 (AEDT)
Date: Sun, 25 Mar 2018 21:14:17 -0400 (EDT)
Message-Id: <20180325.211417.809927177270425883.davem@davemloft.net>
To: dan.carpenter@oracle.com
Cc: benh@kernel.crashing.org, tlfalcon@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com, paulus@samba.org, mpe@ellerman.id.au,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] ibmvnic: Potential NULL dereference in
 clean_one_tx_pool()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180323113615.GA28518@mwanda>
References: <20180323113615.GA28518@mwanda>
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

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 23 Mar 2018 14:36:15 +0300

> There is an && vs || typo here, which potentially leads to a NULL
> dereference.
> 
> Fixes: e9e1e97884b7 ("ibmvnic: Update TX pool cleaning routine")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks Dan.
