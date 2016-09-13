Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvQ5wY7zDsTV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:34 +1000 (AEST)
In-Reply-To: <1473676663-11057-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: cxl: Fix informational message
Message-Id: <3sYNvQ4v8Hz9t0m@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-12-09 at 10:37:43 UTC, Frederic Barrat wrote:
> When set_sl_ops() is called, the adapter data structure is not fully
> initialized yet. Therefore the device name is not showing up in the
> trace. Fix is simply to get the device name from the pci_dev
> structure.
> 
> Fixes: 6d382616ac22 ("cxl: Abstract the differences between the PSL and XSL")
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b135077b83f01549c2a0685b16

cheers
