Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE4F5B6FFB
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 19:43:43 +1100 (EST)
Message-ID: <1329468211.2892.61.camel@pasglop>
Subject: RE: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang-R58472 <r58472@freescale.com>
Date: Fri, 17 Feb 2012 19:43:31 +1100
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F057427B6@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
 <94F013E7935FF44C83EBE7784D62AD3F057427B6@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 04:32 +0000, Li Yang-R58472 wrote:
> >Additionally, outside of maybe P2041RDB I believe the majority of
> these
> >boards ship with 4G of DDR (but that off the top of my head) and thus
> >require the 36-bit / PHYS_64BIT support to be enabled.
> 
> I know that current support of DPAA boards requires 36-bit.  But I
> don't think they need to select the PHYS_64BIT option directly and
> make it not configurable.  It's conflicting with the logic that
> enabling a platform support doesn't mean the kernel is only running on
> that platform.  Btw: what's your recommendations on solving this?

But selecting PHYS_64BIT shouldn't prevent running on the other
platforms. If it does, then this needs to be fixed.

Cheers,
Ben.
