Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNHv2DBJzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:06:03 +1000 (AEST)
In-Reply-To: <20170330040349.GA31756@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: praveen.pandey@in.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/prom: Increase RMA size to 512MB
Message-Id: <3vzNHv1ZFfz9s8T@ozlabs.org>
Date: Thu,  6 Apr 2017 23:06:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-30 at 04:03:49 UTC, Sukadev Bhattiprolu wrote:
> >From 3ae8d1ed31b01b92b172fe20e4560cfbfab135ec Mon Sep 17 00:00:00 2001
> From: root <root@furatripa-lp2.aus.stglabs.ibm.com>
> Date: Mon, 27 Mar 2017 19:43:14 -0400
> Subject: [PATCH] powerpc/prom: Increase RMA size to 512MB
> 
> When booting very large systems with a large initrd, we run out of
> space for either the RTAS or the flattened device tree (FDT). Boot
> fails with messages like:
> 
> 	Could not allocate memory for RTAS
> or
> 	No memory for flatten_device_tree (no room)
> 
> Increasing the minimum RMA size to 512MB fixes the problem. This
> should not have an impact on smaller LPARs (with 256MB memory),
> as the firmware will cap the RMA to the memory assigned to the LPAR.
> 
> Fix is based on input/discussions with Michael Ellerman. Thanks to
> Praveen K. Pandey for testing on a large system.
> 
> Reported-by: Praveen K. Pandey <preveen.pandey@in.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/687da8fce1682c9f1e87530e731189

cheers
