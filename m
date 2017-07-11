Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6MMG04j7zDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:48:26 +1000 (AEST)
In-Reply-To: <20170630223732.32044-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Breno Leitao <brenohl@br.ibm.com>
Subject: Re: [v2] powerpc/powernv: Tell OPAL about our MMU mode on POWER9
Message-Id: <3x6MMF6KvBz9sNc@ozlabs.org>
Date: Tue, 11 Jul 2017 22:48:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-30 at 22:37:32 UTC, Michael Neuling wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> That will allow OPAL to configure the CPU in an optimal way.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1c0eaf0f56d6128af7f0f252855173

cheers
