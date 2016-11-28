Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5Gq5fcgzDt3c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:15:15 +1100 (AEDT)
In-Reply-To: <1479838000-380-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powernv: Clear SPRN_PSSCR when a POWER9 CPU comes online
Message-Id: <3tS5Gq4NNJz9vFg@ozlabs.org>
Date: Mon, 28 Nov 2016 23:15:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-22 at 18:06:40 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Ensure that PSSCR is set to a safe value corresponding to no
> state-loss each time a POWER9 CPU comes online.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Acked-By: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/378f96d3cd442d5cb8e2692d8767a4

cheers
