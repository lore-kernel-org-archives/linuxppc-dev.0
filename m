Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y703d2DlWzDrCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:22:21 +1100 (AEDT)
In-Reply-To: <20171004091505.16776-2-clg@kaod.org>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric_Le_G?= =?utf-8?q?oater?= <clg@kaod.org>
Subject: Re: [v2,1/2] powerpc/xive: fix IPI reset
Message-Id: <3y703d1WD4z9t4X@ozlabs.org>
Date: Thu,  5 Oct 2017 15:22:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-10-04 at 09:15:04 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> When resetting an IPI, hw_ipi should also be set to zero.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/74f1282114acc7d67e25745efe200f

cheers
