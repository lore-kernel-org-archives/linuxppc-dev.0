Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id DE2932C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 05:27:21 +1000 (EST)
Date: Wed, 21 Aug 2013 12:27:18 -0700 (PDT)
Message-Id: <20130821.122718.211023142309177250.davem@davemloft.net>
To: libo.chen@huawei.com
Subject: Re: [PATCH 0/8] net: remove unnecessary dev_set_drvdata()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1377068737-48616-1-git-send-email-libo.chen@huawei.com>
References: <1377068737-48616-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mugunthanvnm@ti.com, sergei.shtylyov@cogentembedded.com,
 netdev@vger.kernel.org, jg1.han@samsung.com, lizefan@huawei.com,
 gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Libo Chen <libo.chen@huawei.com>
Date: Wed, 21 Aug 2013 15:05:37 +0800

> Unnecessary dev_set_drvdata() is removed, because the driver core
> clears the driver data to NULL after device_release or on probe failure.

Series applied, thanks.
