Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94D2C1A1930
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:17 +1000 (AEST)
In-Reply-To: <1435900280-12947-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: Re: [RESEND] powerpc/configs: enable RTC class support
Message-Id: <20150819231417.33D151409A0@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-07 at 05:11:20 UTC, Vaibhav Jain wrote:
> A working rtc kernel driver is needed so that hwclock can synchronize
> system clock to rtc during shutdown/boot. We already have a powernv
> platform rtc driver located at drivers/rtc/rtc-opal.c. However it depends
> on CONFIG_RTC_CLASS which is disabled by default. Hence the driver isn't
> enabled and not compiled for the powernv kernel.
> 
> We fix this by enabling rtc class support in pseries defconfig which
> enables this driver and compiles it into the pseries kernel. In case
> CONFIG_PPC_POWERNV is not enabled we fallback to 'Generic RTC support'
> driver which emulates the legacy 'PC RTC driver'.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e0ad784b65a64a617179

cheers
