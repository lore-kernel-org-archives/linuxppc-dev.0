Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E50EE1A03C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:15:58 +1100 (AEDT)
In-Reply-To: <1447903588-610-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Remove unused function trace_syscall()
Message-Id: <20151126121558.C0B1014031D@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:58 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-19-11 at 03:26:28 UTC, Rashmica Gupta wrote:
> This function has been unused since commit 14cf11af6cf6 ("powerpc: Merge enough
> to start building in arch/powerpc."), so remove it.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cdfc8ed6904d7b0c0ca23d61

cheers
