Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sL10S3zSLzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 09:41:27 +1000 (AEST)
Date: Thu, 25 Aug 2016 16:41:23 -0700 (PDT)
Message-Id: <20160825.164123.36841950077292550.davem@redhat.com>
To: weiyj.lk@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tlfalcon@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 weiyongjun1@huawei.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH -next] ibmvnic: fix error return code in ibmvnic_probe()
From: David Miller <davem@redhat.com>
In-Reply-To: <1472046478-1427-1-git-send-email-weiyj.lk@gmail.com>
References: <1472046478-1427-1-git-send-email-weiyj.lk@gmail.com>
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
Date: Wed, 24 Aug 2016 13:47:58 +0000

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return error code -ENOMEM from the dma_map_single error
> handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied.
