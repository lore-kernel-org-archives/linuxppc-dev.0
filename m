Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 5D0832C010A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 10:19:18 +1000 (EST)
Date: Tue, 20 Aug 2013 17:19:07 -0700 (PDT)
Message-Id: <20130820.171907.865197874462124999.davem@davemloft.net>
To: clbchenlibo.chen@huawei.com
Subject: Re: [PATCH v4 0/7] net: use platform_{get,set}_drvdata()
From: David Miller <davem@davemloft.net>
In-Reply-To: <52120859.7060200@huawei.com>
References: <52120859.7060200@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sergei.shtylyov@cogentembedded.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, jg1.han@samsung.com, lizefan@huawei.com,
 vbordug@ru.mvista.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Libo Chen <clbchenlibo.chen@huawei.com>
Date: Mon, 19 Aug 2013 19:58:17 +0800

> 
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
> 
> changelog v4:
> 	remove modify about happy_meal_pci_probe && happy_meal_pci_remove
> changelog v3:
> 	remove modify about dev_set_drvdata()
> changelog v2:
> 	this version add modify record about dev_set_drvdata().

Series applied.
