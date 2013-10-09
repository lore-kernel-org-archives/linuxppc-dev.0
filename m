Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0C8B92C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 17:52:03 +1100 (EST)
Message-ID: <1381301512.645.272.camel@pasglop>
Subject: Re: [PATCH] powerpc/powernv: Add a debugfs file to read the
 firmware console
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 09 Oct 2013 17:51:52 +1100
In-Reply-To: <20131009060613.GC28160@concordia>
References: <1381218400.645.204.camel@pasglop>
 <20131009032314.GD23780@concordia> <1381292601.645.258.camel@pasglop>
 <20131009060613.GC28160@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-09 at 17:06 +1100, Michael Ellerman wrote:
> Call it twice.
> 
> And you wonder why no one reviews your patches?

Not that easy :-) I had a look at using it and unless I did something
stupid, it wasn't actually that trivial to figure out what arg to pass
it for calling it twice, ie, it didn't simplify the code
significantly ... I had another problem too but I don't remember what
it was. But it could be that I had a very dumb moment...

Cheers,
Ben.
