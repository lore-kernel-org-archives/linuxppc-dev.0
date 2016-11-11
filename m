Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFcX80pFFzDvjZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 22:05:27 +1100 (AEDT)
Message-ID: <1478862296.2592.10.camel@kernel.crashing.org>
Subject: Re: [PATCH 13/38] powerpc: Put exception configuration in a common
 place
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Date: Fri, 11 Nov 2016 22:04:56 +1100
In-Reply-To: <20161111210602.6128fc3f@kryten>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-14-git-send-email-benh@kernel.crashing.org>
 <20161111210602.6128fc3f@kryten>
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

On Fri, 2016-11-11 at 21:06 +1100, Anton Blanchard wrote:
> It looks like we only set LPCR_AIL_3 on the boot CPU after this change,
> is that expected? Before that we did it in cpu_ready_for_interrupts()
> which is called for the primary and all secondary CPUs.

That would be a mistake... I suppose I didn't realize we had to call
these things for every CPU.

I'll try to cook up a fix next week.

Cheers,
Ben.
