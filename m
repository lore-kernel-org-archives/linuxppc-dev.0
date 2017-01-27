Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1Y3152zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:33 +1100 (AEDT)
In-Reply-To: <1485211794-11093-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v2,
 1/3] powerpc/kernel: Remove nested if statements in rtas_initialize()
Message-Id: <3v8g1Y2RMsz9t1B@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-23 at 22:49:52 UTC, Gavin Shan wrote:
> This removes the unnecessary nested if statements in function
> rtas_initialize(), to simplify the code. No functional changes
> introduced.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dbecd5093043faa9da83c720ed0e08

cheers
