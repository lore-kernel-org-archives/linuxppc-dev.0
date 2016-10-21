Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t10614BlVzDvcx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 09:02:33 +1100 (AEDT)
In-Reply-To: <20161018085214.20428-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc: Fix numa topology console print
Message-Id: <3t10612dVmz9t0t@ozlabs.org>
Date: Sat, 22 Oct 2016 09:02:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-18-10 at 08:52:14 UTC, "Aneesh Kumar K.V" wrote:
> With recent update to printk, we get console output like below
> 
> [    0.550639] Brought up 160 CPUs
> [    0.550718] Node 0 CPUs:
> [    0.550721]  0
> [    0.550754] -39
> 
> [    0.550794] Node 1 CPUs:
> [    0.550798]  40
> [    0.550817] -79
> 
> [    0.550856] Node 16 CPUs:
> [    0.550860]  80
> [    0.550880] -119
> 
> [    0.550917] Node 17 CPUs:
> [    0.550923]  120
> [    0.550942] -159
> 
> Fix this by using proper printk args
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8467801cc8744511bd2664fae7d72a

cheers
