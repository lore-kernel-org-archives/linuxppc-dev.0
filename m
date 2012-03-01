Return-Path: <rkuo@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine01.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A07111007D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2012 10:58:57 +1100 (EST)
Date: Thu, 1 Mar 2012 17:48:24 -0600
From: Richard Kuo <rkuo@codeaurora.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] atomic: Allow atomic_inc_not_zero to be overridden
Message-ID: <20120301234824.GC2644@codeaurora.org>
References: <20120301180953.0f61576f@kryten>
 <20120301150256.9a7d0b06.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120301150256.9a7d0b06.akpm@linux-foundation.org>
Cc: vapier@gentoo.org, eric.dumazet@gmail.com, linux-kernel@vger.kernel.org,
 paulus@samba.org, Anton Blanchard <anton@samba.org>,
 linux-hexagon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, asharma@fb.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 01, 2012 at 03:02:56PM -0800, Andrew Morton wrote:
> Please merge this via the ppc tree?
> 
> 
> And let's ask the hexagon maintainers to take a look at the definition
> in arch/hexagon/include/asm/atomic.h.  I assume that it can be removed,
> but that might cause problems with files which include asm/atomic.h
> directly.  I have found two such files in non-arch code and have queued
> fixes.  There are no such files in arch/hexagon code, so I think it's
> safe to zap the hexagon definition of atomic_inc_not_zero().

Just tested it; it's safe to zap the Hexagon definition of
atomic_inc_not_zero()...  I'm fine with this going in through some
other tree (still getting mine set up).


Thanks,
Richard Kuo




-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
