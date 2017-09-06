Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnL8W5BfHzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 20:55:23 +1000 (AEST)
In-Reply-To: <20170830194617.26621-2-clg@kaod.org>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [v3,
 1/8] powerpc/xive: introduce a common routine xive_queue_page_alloc()
Message-Id: <3xnL8W4ZKZz9sCZ@ozlabs.org>
Date: Wed,  6 Sep 2017 20:55:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-30 at 19:46:10 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> This routine will be used in the spapr backend. Also introduce a short
> xive_alloc_order() helper.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/994ea2f41999113d84c317da3ec1e1

cheers
