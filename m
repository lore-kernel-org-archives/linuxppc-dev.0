Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHgzy4gmBzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 02:49:01 +1000 (AEST)
Date: Wed, 26 Jul 2017 09:48:58 -0700 (PDT)
Message-Id: <20170726.094858.1478051591748336400.davem@davemloft.net>
To: paulmck@linux.vnet.ibm.com
Cc: Jonathan.Cameron@huawei.com, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, npiggin@gmail.com, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170726141417.GJ3730@linux.vnet.ibm.com>
References: <20170726103232.0000368e@huawei.com>
 <20170726132801.00001e8c@huawei.com>
 <20170726141417.GJ3730@linux.vnet.ibm.com>
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

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 07:14:17 -0700

> Dave, any other ideas on what might be causing this or what might be
> tested?

I was going to go through the changes that happened between v4.12
and now to kernel/timer/tick-sched.c and see if reverting any of
those help.

But I don't know when I would get to that.

Commit 411fe24e6b7c283c3a1911450cdba6dd3aaea56e, looks particularly juicy.
:-)
