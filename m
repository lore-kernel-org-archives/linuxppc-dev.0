Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhm756ZzDsfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:20 +1000 (AEST)
In-Reply-To: <20160919064132.28760-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries: fix memory leak in queue_hotplug_event() error
 path
Message-Id: <3sdjhm6L7Fz9t0q@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-19-09 at 06:41:32 UTC, Andrew Donnellan wrote:
> If we fail to allocate work, we don't end up using hp_errlog_copy. Free it
> in the error path.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/90ce35145cb622b3cd0007d50e

cheers
