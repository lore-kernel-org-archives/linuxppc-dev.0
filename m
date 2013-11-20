Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 64CA72C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 21:21:53 +1100 (EST)
Message-ID: <528C8D3D.6050600@c-s.fr>
Date: Wed, 20 Nov 2013 11:21:49 +0100
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: BUG: Patch "Convert some mftb/mftbu into mfspr" breaks MPC885
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

The patch "Convert some mftb/mftbu into mfspr" 
(beb2dc0a7a84be003ce54e98b95d65cc66e6e536) breaks startup on MPC885.

The CPU traps (SoftwareEmulation trap) at sched_clock() when trying to 
read TBU with mfspr.

Reverting the patch solves the issue.

What's the prefered way to fix this ?

Christophe
