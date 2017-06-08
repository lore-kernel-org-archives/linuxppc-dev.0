Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkKx23F2dzDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 08:34:46 +1000 (AEST)
In-Reply-To: <20170606094341.14629-1-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, philippe.bergheaud@fr.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] cxl: Fix error path on bad ioctl
Message-Id: <3wkKx22RyBz9s7v@ozlabs.org>
Date: Fri,  9 Jun 2017 08:34:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-06 at 09:43:41 UTC, Frederic Barrat wrote:
> Fix error path if we can't copy user structure on CXL_IOCTL_START_WORK
> ioctl. We shouldn't unlock the context status mutex as it was not
> locked (yet).
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cec422c11caeeccae709e9942058b6

cheers
