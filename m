Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zkgh35mDWzDrTv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Feb 2018 19:55:31 +1100 (AEDT)
In-Reply-To: <1518610667-23406-1-git-send-email-clabbe@baylibre.com>
To: Corentin Labbe <clabbe@baylibre.com>, benh@kernel.crashing.org,
 paulus@samba.org, nfont@linux.vnet.ibm.com, tyreld@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Corentin Labbe <clabbe@baylibre.com>
Subject: Re: powerpc: add empty update_numa_cpu_lookup_table for !CONFIG_NUMA
Message-Id: <3zkgh34GJZz9sWK@ozlabs.org>
Date: Sun, 18 Feb 2018 19:55:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-14 at 12:17:47 UTC, Corentin Labbe wrote:
> When CONFIG_NUMA is not set, build fail with:
> arch/powerpc/platforms/pseries/hotplug-cpu.c:335:4: error: déclaration implicite de la fonction « update_numa_cpu_lookup_table » [-Werror=implicit-function-declaration]
> 
> So we have to add update_numa_cpu_lookup_table as an empty function when CONFIG_NUMA is not set.
> 
> Fixes: 1d9a090783be ("powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c1e150ceb61e4a585bad156da15c33

cheers
