Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zkggq6NbKzDrTR
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Feb 2018 19:55:19 +1100 (AEDT)
In-Reply-To: <20180213084712.18351-1-clg@kaod.org>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: powerpc/xive: use hw CPU ids when configuring the CPU queues
Message-Id: <3zkggq5mSVz9ryg@ozlabs.org>
Date: Sun, 18 Feb 2018 19:55:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-13 at 08:47:12 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> The CPU event notification queues on sPAPR should be configured using
> a hardware CPU identifier.
> 
> The problem did not show up on the Power Hypervisor because pHyp
> supports 8 threads per core which keeps CPU number contiguous. This is
> not the case on all sPAPR virtual machines, some use SMT=1.
> 
> Also improve error logging by adding the CPU number.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8e036c8d30a2cd9d8fc7442fbf6824

cheers
