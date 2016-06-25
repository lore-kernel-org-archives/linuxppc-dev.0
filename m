Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rcKjP49tzzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jun 2016 02:02:49 +1000 (AEST)
Date: Sat, 25 Jun 2016 12:02:41 -0400 (EDT)
Message-Id: <20160625.120241.1521209512436530662.davem@davemloft.net>
To: weiyj_lk@163.com
Cc: tlfalcon@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 netdev@vger.kernel.org, yongjun_wei@trendmicro.com.cn,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] ibmvnic: fix to use list_for_each_safe() when
 delete items
From: David Miller <davem@davemloft.net>
In-Reply-To: <2db3a1f8-cafd-8fde-6223-2b2e3787d615@163.com>
References: <576810C2.6080208@linux.vnet.ibm.com>
 <576964CF.3040804@linux.vnet.ibm.com>
 <2db3a1f8-cafd-8fde-6223-2b2e3787d615@163.com>
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

From: Wei Yongjun <weiyj_lk@163.com>
Date: Wed, 22 Jun 2016 10:51:46 +0800

> Since we will remove items off the list using list_del() we need
> to use a safe version of the list_for_each() macro aptly named
> list_for_each_safe().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Your email client has corrupted the spacing in this patch, making
it unusable.
