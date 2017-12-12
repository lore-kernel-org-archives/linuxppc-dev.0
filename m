Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXS3p67zDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:20 +1100 (AEDT)
In-Reply-To: <20170131180144.GA27740@dtor-ws>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/powermac: drop useless call to of_find_node_by_name
Message-Id: <3ywyXS0cnHz9t3m@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-31 at 18:01:44 UTC, Dmitry Torokhov wrote:
> We are not using result, so this simply results in a leaked refcount.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/df26200299eb05fa7d059cd235847e

cheers
