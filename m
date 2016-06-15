Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTw9n6lDZzDqcd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 15:31:41 +1000 (AEST)
In-Reply-To: <1465404871-5406-4-git-send-email-shreyas@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, benh@au1.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v6,
 03/11] powerpc/powernv: Rename idle_power7.S to idle_power_common.S
Message-Id: <3rTw9n5cZwz9s2G@ozlabs.org>
Date: Wed, 15 Jun 2016 15:31:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-06 at 16:54:23 UTC, "Shreyas B. Prabhu" wrote:
> idle_power7.S handles idle entry/exit for POWER7, POWER8 and in next
> patch for POWER9. Rename the file to a non-hardware specific
> name.

It's not common for all powerpc CPUs though. So can you call it something other
than just "common".

Maybe idle_book3s.S, or (if it's correct) idle_206.S

cheers
