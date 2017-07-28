Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJyQ94L8FzDrS5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 04:42:38 +1000 (AEST)
Date: Fri, 28 Jul 2017 11:42:34 -0700 (PDT)
Message-Id: <20170728.114234.665847938315546094.davem@davemloft.net>
To: boqun.feng@gmail.com
Cc: Jonathan.Cameron@huawei.com, paulmck@linux.vnet.ibm.com,
 dzickus@redhat.com, sfr@canb.auug.org.au, linuxarm@huawei.com,
 npiggin@gmail.com, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170728125416.j7gcgvnxgv2gq73u@tardis>
References: <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
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

From: Boqun Feng <boqun.feng@gmail.com>
Date: Fri, 28 Jul 2017 20:54:16 +0800

> Hi Jonathan,
> 
> FWIW, there is wakeup-missing issue in swake_up() and swake_up_all():
> 
> 	https://marc.info/?l=linux-kernel&m=149750022019663
> 
> and RCU begins to use swait/wake last year, so I thought this could be
> relevant.
> 
> Could you try the following patch and see if it works? Thanks.

Just FYI I'm testing this patch now on sparc64...
