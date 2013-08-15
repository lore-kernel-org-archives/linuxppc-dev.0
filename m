Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 593902C021B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 18:24:07 +1000 (EST)
Date: Thu, 15 Aug 2013 01:24:04 -0700 (PDT)
Message-Id: <20130815.012404.1180223951215075384.davem@davemloft.net>
To: divy@chelsio.com
Subject: Re: [PATCH] Revert "cxgb3: Check and handle the dma mapping errors"
From: David Miller <davem@davemloft.net>
In-Reply-To: <520BA8E4.3010406@chelsio.com>
References: <1376471941-2914-1-git-send-email-aik@ozlabs.ru>
 <520BA8E4.3010406@chelsio.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: santosh@chelsio.com, fenlason@redhat.com, aik@ozlabs.ru,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Divy Le ray <divy@chelsio.com>
Date: Wed, 14 Aug 2013 08:57:24 -0700

> On 08/14/2013 02:19 AM, Alexey Kardashevskiy wrote:
>> This reverts commit f83331bab149e29fa2c49cf102c0cd8c3f1ce9f9.
>>
>> As the tests PPC64 (powernv platform) show, IOMMU pages are leaking
>> when transferring big amount of small packets (<=64 bytes),
>> "ping -f" and waiting for 15 seconds is the simplest way to confirm
>> the bug.
>>
>> Cc: Linus Torvalds<torvalds@linux-foundation.org>
>> Cc: Santosh Rastapur<santosh@chelsio.com>
>> Cc: Jay Fenlason<fenlason@redhat.com>
>> Cc: David S. Miller<davem@davemloft.net>
>> Cc: Divy Le ray<divy@chelsio.com>
>> Signed-off-by: Alexey Kardashevskiy<aik@ozlabs.ru>
> 
> Acked-by: Divy Le Ray <divy@chelsio.com>

Applied, thanks.
