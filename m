Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52A081A0748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 07:58:34 +1000 (AEST)
In-Reply-To: <1440655450-6831-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, j.anaszewski@samsung.com,
 linux-leds@vger.kernel.org, Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc/configs: Enable LEDS support
Message-Id: <20150827215834.3EF841401C7@ozlabs.org>
Date: Fri, 28 Aug 2015 07:58:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-27-08 at 06:04:10 UTC, Vasant Hegde wrote:
> Commit 84ad6e5c added LEDS support for PowerNV platform. Lets
> update ppc64_defconfig to pick LEDS driver.
> 
> PowerNV LEDS driver looks for "/ibm,opal/leds" node in device
> tree and loads if this node exists. Hence added it as 'm'.
> 
> Also note that powernv LEDS driver needs NEW_LEDS and LEDS_CLASS
> as well. Hence added them to config file.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Cc: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d690740f22f6520873f96e66

cheers
