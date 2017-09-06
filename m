Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnL8b4ZLWzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 20:55:27 +1000 (AEST)
In-Reply-To: <20170904063755.6836-1-clg@kaod.org>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: powerpc/xive: Fix section __init warning
Message-Id: <3xnL8b3SnDz9t3f@ozlabs.org>
Date: Wed,  6 Sep 2017 20:55:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-09-04 at 06:37:55 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> xive_spapr_init() is called from a __init routine and calls __init
> routines.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/265601f034df3566f22da11240977a

cheers
