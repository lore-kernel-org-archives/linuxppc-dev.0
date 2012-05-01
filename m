Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0AC35B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2012 14:37:59 +1000 (EST)
Message-ID: <1335845444.3621.11.camel@pasglop>
Subject: Re: [PATCH v3 03/17] powerpc: Add PFO support to the VIO bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kent Yoder <key@linux.vnet.ibm.com>
In-Reply-To: <1335841603.3621.8.camel@pasglop>
References: <1334242825.18090.4.camel@key-ThinkPad-W510>
 <1334243302.18090.10.camel@key-ThinkPad-W510>
 <1335841603.3621.8.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 May 2012 14:10:44 +1000
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Else, what about ceding the processor ? Or at the very least reducing
> the thread priority for a bit ?
> 
> Shouldn't we also enforce to always have a timeout ? IE. Something like
> 30s or so if nothing specified to avoid having the kernel just hard
> lock...
> 
> In general I don't like that sort of synchronous code, I'd rather return
> the busy status up the chain which gives a chance to the caller to take
> more appropriate measures depending on what it's doing, but that really
> depends what you use that synchronous call for. I suppose if it's for
> configuration type operations, it's ok...

In any case, don't resend the whole series, just that one patch.

Cheers,
Ben.
