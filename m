Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHG0vFxzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:18:50 +1000 (AEST)
In-Reply-To: <1469171795-9879-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: Re: powerpc/powernv: document cxl dependency on special case in
 pnv_eeh_reset()
Message-Id: <3wJCHG05KZz9rxm@ozlabs.org>
Date: Thu,  4 May 2017 08:18:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-07-22 at 07:16:35 UTC, Andrew Donnellan wrote:
> pnv_eeh_reset() has special handling for PEs whose primary bus is the root
> bus or the bus immediately underneath the root port.
> 
> The cxl bi-modal card support added in b0b5e5918ad1 ("cxl: Add
> cxl_check_and_switch_mode() API to switch bi-modal cards") relies on this
> behaviour when hot-resetting the CAPI adapter following a mode switch.
> Document this in pnv_eeh_reset() so we don't accidentally break it.
> 
> Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b7da1230532984fc00962b2c8be94a

cheers
