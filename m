Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNG5RpBzDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:50 +1100 (AEDT)
In-Reply-To: <20180123113148.6024-2-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: gregkh@linuxfoundation.org, alastair@au1.ibm.com,
 andrew.donnellan@au1.ibm.com, arnd@arndb.de
Subject: Re: [v2,
 01/13] powerpc/powernv: Introduce new PHB type for opencapi links
Message-Id: <3zVGNG2fp8z9s7n@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:49 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-23 at 11:31:36 UTC, Frederic Barrat wrote:
> The NPU was already abstracted by opal as a virtual PHB for nvlink,
> but it helps to be able to differentiate between a nvlink or opencapi
> PHB, as it's not completely transparent to linux. In particular, PE
> assignment differs and we'll also need the information in later
> patches.
> 
> So rename existing PNV_PHB_NPU type to PNV_PHB_NPU_NVLINK and add a
> new type PNV_PHB_NPU_OCAPI.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7f2c39e91f61fcd2abed3b39c14e70

cheers
