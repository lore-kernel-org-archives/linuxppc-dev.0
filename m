Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RHS2K2FzDqsV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:52 +1100 (AEDT)
In-Reply-To: <20180308003606.10721-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/powernv/mce: Don't silently restart the machine
Message-Id: <401RHR65YBz9sVj@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-08 at 00:36:06 UTC, Balbir Singh wrote:
> On MCE the current code will restart the machine with
> ppc_md.restart(). This case was extremely unlikely since
> prior to that a skiboot call is made and that resulted in
> a checkstop for analysis.
> 
> With newer skiboots, on P9 we don't checkstop the box by
> default, instead we return back to the kernel to extract
> useful information at the time of the MCE. While we still
> get this information, this patch converts the restart to
> a panic(), so that if configured a dump can be taken and
> we can track and probably debug the potential issue causing
> the MCE.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5ee573e8ef034e687c420cb1091137

cheers
