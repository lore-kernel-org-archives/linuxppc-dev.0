Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E5B36B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 12:55:12 +1100 (EST)
Message-ID: <1329962108.20389.19.camel@pasglop>
Subject: Re: powerpc/mpic: Fix allocation of reverse-map for multi-ISU mpics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 23 Feb 2012 12:55:08 +1100
In-Reply-To: <20120223013947.GC3212@ponder.secretlab.ca>
References: <1329954613.20389.15.camel@pasglop>
 <20120223013947.GC3212@ponder.secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-02-22 at 18:39 -0700, Grant Likely wrote:
> 
> Looks fine to me.  This will conflict with the irqdomain tree in linux-next,
> but it will be a trivial fixup.  Still, if you prefer I can pick this
> up into my tree.

Well, I'm also going to carry a slightly modified variant of Kyle's
mpic series so we'll have to deal with conflicts regardless, I'll
keep that one.

What I might do tho is pull your tree in powerpc-next at some point,
when you tell me it's frozen solid, this will potentially make my life
easier.

Cheers,
Ben.
