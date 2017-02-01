Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vClL401mNzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:05:32 +1100 (AEDT)
In-Reply-To: <1479314703-18989-1-git-send-email-arbab@linux.vnet.ibm.com>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-mm@kvack.org, John Allen <jallen@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: allow memory hotplug into an offline node
Message-Id: <3vClL33fB1z9t9b@ozlabs.org>
Date: Wed,  1 Feb 2017 12:05:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-16 at 16:45:03 UTC, Reza Arbab wrote:
> Relax the check preventing us from hotplugging into an offline node.
> 
> This limitation was added in commit 482ec7c403d2 ("[PATCH] powerpc numa:
> Support sparse online node map") to prevent adding resources to an
> uninitialized node.
> 
> These days, there is no harm in doing so. The addition will actually
> cause the node to be initialized and onlined; add_memory_resource()
> calls hotadd_new_pgdat() (if necessary) and node_set_online().
> 
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: John Allen <jallen@linux.vnet.ibm.com>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2a8628d41602dc9f988af051a657ee

cheers
