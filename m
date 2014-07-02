Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 365821A0006
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 14:06:46 +1000 (EST)
Message-ID: <1404274005.7254.0.camel@concordia>
Subject: Re: [PATCH V3] powerpc/powernv: Check for IRQHAPPENED before sleeping
From: Michael Ellerman <mpe@ellerman.id.au>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 02 Jul 2014 14:06:45 +1000
In-Reply-To: <20140702034811.2956.30873.stgit@preeti.in.ibm.com>
References: <20140702034811.2956.30873.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, shreyas@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-02 at 09:19 +0530, Preeti U Murthy wrote:
> Commit 8d6f7c5a: "powerpc/powernv: Make it possible to skip the IRQHAPPENED
> check in power7_nap()" added code that prevents cpus from checking for
> pending interrupts just before entering sleep state, which is wrong. These
> interrupts are delivered during the soft irq disabled state of the cpu.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
