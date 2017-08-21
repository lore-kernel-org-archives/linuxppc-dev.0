Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbmCw2rBXzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 06:55:07 +1000 (AEST)
Date: Mon, 21 Aug 2017 13:55:04 -0700 (PDT)
Message-Id: <20170821.135504.1392954698746959868.davem@davemloft.net>
To: npiggin@gmail.com
Cc: Jonathan.Cameron@huawei.com, paulmck@linux.vnet.ibm.com,
 mpe@ellerman.id.au, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, abdhalee@linux.vnet.ibm.com, tglx@linutronix.de,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 john.stultz@linaro.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170822001928.74f01322@roar.ozlabs.ibm.com>
References: <20170821160605.5b1cc019@roar.ozlabs.ibm.com>
 <20170821111833.00006753@huawei.com>
 <20170822001928.74f01322@roar.ozlabs.ibm.com>
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

From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 22 Aug 2017 00:19:28 +1000

> Thanks here's an updated version with a couple more bugs fixed. If
> you could try testing, that would be much appreciated.

I'm not getting RCU stalls on sparc64 any longer with this patch.

I'm really happy you guys were able to figure out what was going
wrong. :-)

Feel free to add my Tested-by:
