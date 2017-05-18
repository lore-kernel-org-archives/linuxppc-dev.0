Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wTLZr15NlzDqcH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 05:18:57 +1000 (AEST)
Date: Thu, 18 May 2017 15:18:47 -0400 (EDT)
Message-Id: <20170518.151847.1221004357174431330.davem@davemloft.net>
To: weiyj.lk@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, weiyongjun1@huawei.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ibmvnic: fix missing unlock on error in
 __ibmvnic_reset()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170518152452.8606-1-weiyj.lk@gmail.com>
References: <20170518152452.8606-1-weiyj.lk@gmail.com>
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

From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Thu, 18 May 2017 15:24:52 +0000

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Add the missing unlock before return from function __ibmvnic_reset()
> in the error handling case.
> 
> Fixes: ed651a10875f ("ibmvnic: Updated reset handling")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
