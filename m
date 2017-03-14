Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjCc12FBLzDqpw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:45:53 +1100 (AEDT)
In-Reply-To: <1487599143-28749-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Handle sdar_mode for marked event in power9
Message-Id: <3vjCc11ZPJz9s3s@ozlabs.org>
Date: Tue, 14 Mar 2017 22:45:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-20 at 13:59:03 UTC, Madhavan Srinivasan wrote:
> MMCRA[SDAR_MODE] specifices how the SDAR should be updated in
> continous sampling mode. On P9 it must be set to 0b00 when
> MMCRA[63] is set.
> 
> Fixes: c7c3f568beff2 ('powerpc/perf: macros for power9 format encoding')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/78b4416aa249365dd3c1b64da4d3a2

cheers
