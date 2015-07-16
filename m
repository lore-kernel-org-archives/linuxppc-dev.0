Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B88A1A08A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 19:54:59 +1000 (AEST)
In-Reply-To: <1436368476-30592-1-git-send-email-jthumshirn@suse.de>
To: Johannes Thumshirn <jthumshirn@suse.de>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: cxl: Destroy cxl_adapter_idr on module_exit
Message-Id: <20150716095458.EB6061409A0@ozlabs.org>
Date: Thu, 16 Jul 2015 19:54:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-08-07 at 15:14:36 UTC, Johannes Thumshirn wrote:
> Destroy cxl_adapter_idr on module exit, reclaiming the allocated memory.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b2a02ac65e40fb3900d1

cheers
