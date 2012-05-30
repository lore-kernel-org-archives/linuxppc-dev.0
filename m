Return-Path: <ppc@mindchasers.com>
Received: from vms173019pub.verizon.net (vms173019pub.verizon.net
 [206.46.173.19]) by ozlabs.org (Postfix) with ESMTP id EB621B7016
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 00:27:53 +1000 (EST)
Received: from [192.168.1.3] ([unknown] [108.25.196.140])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M4U00F2L80OAR23@vms173019.mailsrvcs.net> for
 linuxppc-dev@ozlabs.org; Wed, 30 May 2012 08:26:54 -0500 (CDT)
Message-id: <4FC62018.3040404@mindchasers.com>
Date: Wed, 30 May 2012 09:26:48 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
In-reply-to: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2012 03:43 AM, Joakim Tjernlund wrote:
> Emulators such as BDI2000 and CodeWarrior needs to have MSR_DE set
> in order to support break points.
> This adds MSR_DE for kernel space only.
> ---
>
> I have tested this briefly with BDI2000 on P2010(e500) and
> it works for me. I don't know if there are any bad side effects, therfore
> this RFC.
>
>   arch/powerpc/include/asm/reg.h       |    2 +-
>   arch/powerpc/include/asm/reg_booke.h |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
snip


I believe that additional patches are required for CodeWarrior to work 
properly (e.g., assembly start up).  I think the patches should come 
from Freescale.  For whatever reason, they include them in their SDK, 
but haven't submitted them for inclusion in the mainline.

As a developer on Freescale Power products, I would like to see 
Freescale offer up a CodeWarrior patch set, so I don't have to manage 
the patches myself when working outside the SDK (i.e., on a more recent 
kernel).
