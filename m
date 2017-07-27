Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBNQ1xzpzDrJP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:38:30 +1000 (AEST)
In-Reply-To: <20170721145139.9384-1-lvivier@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Thomas Huth <thuth@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/pseries: Fix of_node_put() underflow during pseries remove
Message-Id: <3xJBNQ0hqTz9s76@ozlabs.org>
Date: Thu, 27 Jul 2017 22:38:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-07-21 at 14:51:39 UTC, Laurent Vivier wrote:
> As for commit 68baf692c435 ("powerpc/pseries: Fix of_node_put()
> underflow during DLPAR remove"), the call to of_node_put()
> must be removed from pSeries_reconfig_remove_node().
> 
> dlpar_detach_node() and pSeries_reconfig_remove_node() call
> of_detach_node(), and thus the node should not be released
> in this case too.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4fd1bd443e80b12f0a01a45fb9a793

cheers
