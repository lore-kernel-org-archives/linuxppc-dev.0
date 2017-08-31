Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLm22KyzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:32 +1000 (AEST)
In-Reply-To: <20170830002745.29526-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/xmon: hdec is now 64bits
Message-Id: <3xjgLl3sjNz9t3s@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 00:27:44 UTC, Balbir Singh wrote:
> ISA 300 defines hypervisor decrementer to be 64 bits in length.
> This patch extends the print format for all archs to be 64 bits
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cf9159c36cca6b3d82a6eb620055b3

cheers
