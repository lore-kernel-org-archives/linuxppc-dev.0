Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xZl6J62S4zDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 15:01:43 +1000 (AEST)
Date: Sat, 19 Aug 2017 22:01:38 -0700 (PDT)
Message-Id: <20170819.220138.235199150058320061.davem@davemloft.net>
To: npiggin@gmail.com
Cc: paulmck@linux.vnet.ibm.com, mpe@ellerman.id.au,
 Jonathan.Cameron@huawei.com, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, abdhalee@linux.vnet.ibm.com, tglx@linutronix.de,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 john.stultz@linaro.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170820144553.2ab2727b@ppc64le>
References: <20170816125617.GY7017@linux.vnet.ibm.com>
 <20170816162731.GA22978@linux.vnet.ibm.com>
 <20170820144553.2ab2727b@ppc64le>
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
Date: Sun, 20 Aug 2017 14:45:53 +1000

> [PATCH] timers: Fix excessive granularity of new timers after a nohz idle

I just booted into this on my sparc64 box, let's see if it does the
trick :-)
