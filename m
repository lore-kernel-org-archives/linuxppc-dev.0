Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPxBd5C3MzDvwy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:04:09 +1100 (AEDT)
In-Reply-To: <20161116011226.24589-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: alistair@popple.id.au, gwshan@linux.vnet.ibm.com,
 Russell Currey <ruscur@russell.cc>
Subject: Re: powerpc/powernv: Don't warn on PE init if unfreeze is unsupported
Message-Id: <3tPxBd2CWHz9t2G@ozlabs.org>
Date: Fri, 25 Nov 2016 11:04:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-16 at 01:12:26 UTC, Russell Currey wrote:
> Whenever a PE is initialised in powernv, opal_pci_eeh_freeze_clear() is
> called.  This is to remove any existing freeze, and has no negative side
> effects if the PE is already in an unfrozen state.  On PHB backends that
> don't support this operation and return OPAL_UNSUPPORTED, this creates a
> scary and misleading warning message.
> 
> Skip the warning message on init if OPAL_UNSUPPORTED is returned.
> 
> As far as I'm aware, this currently only affects NPUs.
> 
> Fixes: 313483d ("powerpc/powernv: Unfreeze PE on allocation")
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d4791db527bf397c84c9956c3ece96

cheers
