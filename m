Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0287F1A15E8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:36 +1100 (AEDT)
In-Reply-To: <1449641900-22089-2-git-send-email-stewart@linux.vnet.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [v2,1/3] powerpc/powernv: panic() on OPAL < V3
Message-Id: <20151217115735.DEB571402BB@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-12 at 06:18:18 UTC, Stewart Smith wrote:
> The OpenPower Abstraction Layer firmware went through a couple
> of iterations in the lab before being released. What we now know
> as OPAL advertises itself as OPALv3.
> 
> OPALv2 and OPALv1 never made it outside the lab, and the possibility
> of anyone at all ever building a mainline kernel today and expecting
> it to boot on such hardware is zero.
> 
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/786842b62f81f20d14894925e8

cheers
