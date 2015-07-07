Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 652911A1059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 20:38:05 +1000 (AEST)
In-Reply-To: <1436213363-18419-1-git-send-email-shreyas@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc/powernv: Fix race in updating core_idle_state
Message-Id: <20150707103805.428031402C3@ozlabs.org>
Date: Tue,  7 Jul 2015 20:38:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-07 at 20:09:23 UTC, "Shreyas B. Prabhu" wrote:
> core_idle_state is maintained for each core. It uses 0-7 bits to track
> whether a thread in the core has entered fastsleep or winkle. 8th bit is
> used as a lock bit.
...
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Fixes: 7b54e9f213f76 'powernv/powerpc: Add winkle support for offline
> cpus'

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=b32aadc1a8ed84afbe924cd2ced31cd6a2e67074

cheers
