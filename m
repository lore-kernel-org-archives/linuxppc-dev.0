Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN27q344HzDqy0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:40:23 +1100 (AEDT)
In-Reply-To: <1485989562-16741-1-git-send-email-shailendras@nvidia.com>
To: Shailendra Singh <shailendras@nvidia.com>, <linuxppc-dev@lists.ozlabs.org>,
 <jk@ozlabs.org>, <shailendras@nvidia.com>, <apopple@au1.ibm.com>,
 <balbirs@au1.ibm.com>, <aritger@nvidia.com>, <jhubbard@nvidia.com>,
 <scheung@nvidia.com>, <amanjunatha@nvidia.com>, <jmckenna@nvidia.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Fix inconsistent of_node_to_nid EXPORT_SYMBOL handling
Message-Id: <3vN27q2Kghz9s72@ozlabs.org>
Date: Tue, 14 Feb 2017 23:40:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-01 at 22:52:42 UTC, Shailendra Singh wrote:
> The generic implementation of of_node_to_nid is EXPORT_SYMBOL.
> 
> The powerpc implementation added by following commit is EXPORT_SYMBOL_GPL.
> commit 953039c8df7b ("[PATCH] powerpc: Allow devices to register with numa
> topology")
> 
> This creates an inconsistency for of_node_to_nid callers across
> architectures.
> 
> Update the powerpc implementation to be exported consistently with the
> generic implementation.
> 
> Signed-off-by: Shailendra Singh <shailendras@nvidia.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/be9ba9ff93cc3e44dc46da9ed25655

cheers
