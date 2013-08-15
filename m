Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 763992C016A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 08:24:02 +1000 (EST)
Date: Thu, 15 Aug 2013 15:23:59 -0700 (PDT)
Message-Id: <20130815.152359.920302339053249583.davem@davemloft.net>
To: clbchenlibo.chen@huawei.com
Subject: Re: [PATCH v3 0/7] net: use platform_{get,set}_drvdata()
From: David Miller <davem@davemloft.net>
In-Reply-To: <520CD11D.8010202@huawei.com>
References: <520CD11D.8010202@huawei.com>
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
Date: Thu, 15 Aug 2013 21:01:17 +0800

> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
> 
> changelog v3:
> 	remove modify about dev_set_drvdata()
> changelog v2:
> 	this version add modify record about dev_set_drvdata().

Series applied.
