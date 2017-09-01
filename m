Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKq85QRjzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:56 +1000 (AEST)
In-Reply-To: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
To: John Allen <jallen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries: Don't attempt to acquire drc during memory hot
 add for assigned lmbs
Message-Id: <3xkKq82ypvz9t3t@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-23 at 17:18:43 UTC, John Allen wrote:
> Check if an LMB is assigned before attempting to call dlpar_acquire_drc in
> order to avoid any unnecessary rtas calls. This substantially reduces the
> running time of memory hot add on lpars with large amounts of memory.
> 
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/afb5519fdb346201728040cab4e08c

cheers
