Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 370631A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 16:34:08 +1100 (AEDT)
In-Reply-To: <1452703822-29844-1-git-send-email-chandan@linux.vnet.ibm.com>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: chandan@mykolab.com, Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: powerpc: Wire up copy_file_range() syscall
Message-Id: <20160121053407.EC92A140BF9@ozlabs.org>
Date: Thu, 21 Jan 2016 16:34:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-01 at 16:50:22 UTC, Chandan Rajendra wrote:
> Test runs on a ppc64 BE guest succeeded.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d7f9ee60a6ebc263861a1d8c06

cheers
