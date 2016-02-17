Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 223BB1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:41:30 +1100 (AEDT)
In-Reply-To: <1454902759-8212-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: gwshan@linux.vnet.ibm.com
Subject: Re: powerpc/eeh: fix incorrect function name in comment
Message-Id: <20160217124129.E23EB1409C2@ozlabs.org>
Date: Wed, 17 Feb 2016 23:41:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-02 at 03:39:19 UTC, Andrew Donnellan wrote:
> The comment block above pcibios_set_pcie_reset_state() incorrectly refers
> to pcibios_set_pcie_slot_reset(). Fix the comment accordingly.
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/31f6a4ada14de04ee6cd7ff03c

cheers
