Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP8FJ1PvlzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 00:19:32 +1000 (AEST)
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Is SPARSE_IRQ really needed for all powerpcs ?
Message-ID: <557c11e6-2585-19c3-d246-2ac54368c62d@c-s.fr>
Date: Fri, 4 Aug 2017 16:18:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The help associated with SPARSE_IRQ says:


   Sparse irq numbering is useful for distro kernels that want
   to define a high CONFIG_NR_CPUS value but still want to have
   low kernel memory footprint on smaller machines.

   ( Sparse irqs can also be beneficial on NUMA boxes, as they spread
     out the interrupt descriptors in a more NUMA-friendly way. )

   If you don't know what to do here, say N.



Is it really usefull/necessary to select it for all powerpc as done by 
arch/powerpc/Kconfig ?

Shouldn't we at least make if conditionnal to SMP ?

Christophe
