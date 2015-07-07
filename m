Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D896E1A0E24
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 10:22:38 +1000 (AEST)
Message-ID: <1436228558.3341.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/powernv: Fix race in updating core_idle_state
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 07 Jul 2015 10:22:38 +1000
In-Reply-To: <1436213363-18419-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1436213363-18419-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-07 at 01:39 +0530, Shreyas B. Prabhu wrote:
> core_idle_state is maintained for each core. It uses 0-7 bits to track
> whether a thread in the core has entered fastsleep or winkle. 8th bit is
> used as a lock bit.
...
> This patch fixes the above race by looping on the lock bit even while
> entering the idle states.
> 
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Fixes: 7b54e9f213f76 'powernv/powerpc: Add winkle support for offline
> cpus'

The sha is wrong, it should be 77b54e9f213f.

Also please don't wrap the description.

I recommend creating an alias or script that does:

$ git log --pretty=fixes -n 1 $commit | xclip


I've fixed it up, no need to resend.

cheers
