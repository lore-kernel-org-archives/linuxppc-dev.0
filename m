Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FPpB5gNlzF3Jb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 13:03:59 +1000 (AEST)
Date: Tue, 18 Sep 2018 20:03:49 -0700 (PDT)
Message-Id: <20180918.200349.177775356017382984.davem@redhat.com>
To: yuehaibing@huawei.com
Cc: dougmill@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, tlfalcon@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com, ivan@de.ibm.com, chunkeey@gmail.com,
 keescook@chromium.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] net: ibm: fix return type of ndo_start_xmit
 function
From: David Miller <davem@redhat.com>
In-Reply-To: <20180918063547.25644-1-yuehaibing@huawei.com>
References: <20180918063547.25644-1-yuehaibing@huawei.com>
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

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 18 Sep 2018 14:35:47 +0800

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
