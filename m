Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHbzD1bN1zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:48:24 +1100 (AEDT)
In-Reply-To: <20170929042655.14570-2-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [v4,
 1/5] powerpc/mce.c: Remove unused function get_mce_fault_addr()
Message-Id: <3yHbzC6vsTz9tX4@ozlabs.org>
Date: Thu, 19 Oct 2017 15:48:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-29 at 04:26:51 UTC, Balbir Singh wrote:
> There are no users of get_mce_fault_addr()
> 
> Fixes: b63a0ff ("powerpc/powernv: Machine check exception handling.")
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/73e341eb6bea01fde706d10d7edba9

cheers
