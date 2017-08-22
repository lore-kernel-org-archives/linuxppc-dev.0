Return-Path: <jonathan.cameron@huawei.com>
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc2lK3zyszDqMV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 17:49:49 +1000 (AEST)
Date: Tue, 22 Aug 2017 08:49:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Miller <davem@davemloft.net>
CC: <npiggin@gmail.com>, <paulmck@linux.vnet.ibm.com>, <mpe@ellerman.id.au>,
 <dzickus@redhat.com>, <sfr@canb.auug.org.au>, <linuxarm@huawei.com>,
 <abdhalee@linux.vnet.ibm.com>, <tglx@linutronix.de>,
 <sparclinux@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <john.stultz@linaro.org>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170822084911.00000c23@huawei.com>
In-Reply-To: <20170821.135504.1392954698746959868.davem@davemloft.net>
References: <20170821160605.5b1cc019@roar.ozlabs.ibm.com>
 <20170821111833.00006753@huawei.com>
 <20170822001928.74f01322@roar.ozlabs.ibm.com>
 <20170821.135504.1392954698746959868.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 21 Aug 2017 13:55:04 -0700
David Miller <davem@davemloft.net> wrote:

> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Tue, 22 Aug 2017 00:19:28 +1000
> 
> > Thanks here's an updated version with a couple more bugs fixed. If
> > you could try testing, that would be much appreciated.  
> 
> I'm not getting RCU stalls on sparc64 any longer with this patch.
> 
> I'm really happy you guys were able to figure out what was going
> wrong. :-)
> 
> Feel free to add my Tested-by:
> 

Like wise - 16 hours of clean run with the latest

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for all the hard work everyone put into this one, great to
cross it off the list!

Jonathan
