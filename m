Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBM441txzDrJ6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:37:20 +1000 (AEST)
In-Reply-To: <1500413796-18340-2-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [v13,1/5] powerpc/platform/powernv: Update IMC OPAL APIs
Message-Id: <3xJBM42LFFz9sN5@ozlabs.org>
Date: Thu, 27 Jul 2017 22:37:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-18 at 21:36:32 UTC, Madhavan Srinivasan wrote:
> In-Memory Collection (IMC) counters are performance monitoring infrastrcuture.
> These counters need special sequence of scoms to init/start/stop which is handled
> by OPAL. And OPAL provides three APIs to init and control these IMC engines.
> 
> OPAL API documentation:
>   https://github.com/open-power/skiboot/blob/master/doc/opal-api/opal-imc-counters.rst
> 
> Patch updates the kernel side powernv platform code to support the new OPAL APIs
> 
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/28a5db0061014c8afbbb98560cf420

cheers
