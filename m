Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA03F1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 07:38:50 +1100 (AEDT)
Message-ID: <1426711109.4770.78.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/dma: Remove ZONE_DMA completely
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 19 Mar 2015 07:38:29 +1100
In-Reply-To: <87zj7amlqn.fsf@linux.vnet.ibm.com>
References: <1424421344.27448.43.camel@kernel.crashing.org>
 <87zj7amlqn.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-18 at 19:49 +0530, Aneesh Kumar K.V wrote:
> Why not do it also for DMA32 as below. We call limit_zone_pfn() only
> for few
> platforms. They can select ZONE_DMA32. Everywhere else ZONE_DMA32 is
> same as ZONE_NORMAL ? So instead of having confusing output for
> show_mem(), we now have

There may be cases where we want ZONE_DMA32, what's confusing ?

Ben.
