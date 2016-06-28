Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf4Pd20JNzDqnk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 22:10:13 +1000 (AEST)
In-Reply-To: <1466580187.4089.23.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/pci: Reduce log level of PCI I/O space warning
Message-Id: <3rf4Pd09Kwz9sCk@ozlabs.org>
Date: Tue, 28 Jun 2016 22:10:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-22-06 at 07:23:07 UTC, Benjamin Herrenschmidt wrote:
> If a PHB has no I/O space, there's no need to make it look like
> something bad happened, a pr_debug() is plenty enough since this
> is the case of all our modern POWER chips.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cdb1b3424dba7d38a2835f6f5f

cheers
