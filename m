Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb3lF41BBzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 10:29:45 +1100 (AEDT)
In-Reply-To: <20160324171221.GB10758@simonLocalRHEL7.x64>
To: Simon Guo <wei.guo.simon@gmail.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Simon Guo <wei.guo.simon@gmail.com>,
 linux-kernel@vger.kernel.org, simonguo@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: powerpc: correct VSX used_vsr comment
Message-Id: <3qb3lF2WYRz9snl@ozlabs.org>
Date: Thu, 31 Mar 2016 10:29:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-24-03 at 17:12:21 UTC, Simon Guo wrote:
> used_vsr flag is set if process has used VSX register, 
> instead of Altivec register. 
> This patch corrects the wrong comment.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/71528d8bd7a8aa920cd69d4223

cheers
