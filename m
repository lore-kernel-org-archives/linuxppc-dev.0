Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E02B51A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 21:10:56 +1100 (AEDT)
In-Reply-To: <1443763413-8318-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: Re: cxl: Workaround malformed pcie packets on some cards
Message-Id: <20151007101056.90DB5140D6E@ozlabs.org>
Date: Wed,  7 Oct 2015 21:10:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-10 at 05:23:33 UTC, Ian Munsie wrote:
> From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> 
> This works around a pcie host bridge defect on some cards, that can cause
> malformed Transaction Layer Packet (TLP) errors to be erroneously reported.
> 
> The upper nibble of the vendor section PSL revision is used to distinguish
> between different cards. The affected ones have it set to 0.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d79e6801b1868ff65f4c956d

cheers
