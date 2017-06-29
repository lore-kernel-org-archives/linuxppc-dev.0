Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz9Gw1WCwzDr57
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 05:49:43 +1000 (AEST)
Date: Thu, 29 Jun 2017 15:49:37 -0400 (EDT)
Message-Id: <20170629.154937.1428574116488487036.davem@davemloft.net>
To: arvind.yadav.cs@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ibm: ibmveth: constify dev_pm_ops structures.
From: David Miller <davem@davemloft.net>
In-Reply-To: <24303710c4e099faa0ca7d9d92a71e53d6b66bcc.1498714986.git.arvind.yadav.cs@gmail.com>
References: <24303710c4e099faa0ca7d9d92a71e53d6b66bcc.1498714986.git.arvind.yadav.cs@gmail.com>
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

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 29 Jun 2017 11:14:50 +0530

> dev_pm_ops are not supposed to change at runtime. All functions
> working with dev_pm_ops provided by <linux/device.h> work with const
> dev_pm_ops. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   15426	   1256	      0	  16682	   412a	drivers/net/ethernet/ibm/ibmveth.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>   15618	   1064	      0	  16682	   412a	drivers/net/ethernet/ibm/ibmveth.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied.
