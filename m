Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC3B91A0100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 17:42:27 +1100 (AEDT)
Message-ID: <1415860935.666.0.camel@kernel.crashing.org>
Subject: Re: powerpc/powernv: Support OPAL requested heartbeat
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 13 Nov 2014 17:42:15 +1100
In-Reply-To: <20141113052937.17DFF1400D2@ozlabs.org>
References: <20141113052937.17DFF1400D2@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jeremy.kerr@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-13 at 16:29 +1100, Michael Ellerman wrote:
> I'd assume "freq" with no units is in HZ, but looks like it's
> milliseconds. I guess it's too late to rename it.

We still can, we haven't cut an official build with that fw, jk ?

Cheers,
Ben.
