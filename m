Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltx36jHWzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:31 +1000 (AEST)
In-Reply-To: <20180727230639.25413-2-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 diana.craciun@nxp.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: oss@buserror.net, bharat.bhushan@nxp.com, leoyang.li@nxp.com
Subject: Re: [v5,
 1/8] powerpc/64: Disable the speculation barrier from the command line
Message-Id: <41ltwy2SDqz9s7Q@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-07-27 at 23:06:32 UTC, Michael Ellerman wrote:
> From: Diana Craciun <diana.craciun@nxp.com>
> 
> The speculation barrier can be disabled from the command line
> with the parameter: "nospectre_v1".
> 
> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/cf175dc315f90185128fb061dc05b6

cheers
