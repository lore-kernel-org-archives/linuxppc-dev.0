Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwKZf4H1qzDqB3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 11:52:10 +1000 (AEST)
In-Reply-To: <1461301069-12331-2-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com, Frank Haverkamp <HAVERKAM@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [2/2] cxl: Poll for outstanding IRQs when detaching a context
Message-Id: <3qwKZf0gF2z9t74@ozlabs.org>
Date: Thu, 28 Apr 2016 11:52:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-22-04 at 04:57:49 UTC, Michael Neuling wrote:
> When detaching contexts, we may still have interrupts in the system
> which are yet to be delivered to any CPU and be acked in the PSL.
> This can result in a subsequent unrelated process getting an spurious
> IRQ or an interrupt for a non-existent context.
> 
> This polls the PSL to ensure that the PSL is clear of IRQs for the
> detached context, before removing the context from the idr.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Tested-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2bc79ffcbb817873cc43d63118

cheers
