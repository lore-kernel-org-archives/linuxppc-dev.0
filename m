Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 29E372C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 07:59:23 +1000 (EST)
Message-ID: <1375480754.15999.42.camel@pasglop>
Subject: Re: [PATCH] drivers/crypto/nx: saves chaining value from co-processor
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Date: Sat, 03 Aug 2013 07:59:14 +1000
In-Reply-To: <1375480550.32477.19.camel@what-is-leg>
References: <1375477090.32477.10.camel@what-is-leg>
 <1375477741.15999.23.camel@pasglop> <1375480550.32477.19.camel@what-is-leg>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-02 at 16:55 -0500, Fionnuala Gunter wrote:
> Sorry, I thought linuxppc-dev was the right tree since the patch is
> for
> a ppc driver and you've carried previous nx driver submissions
> upstream. 
> 
> I want to submit to the proper place, so what is your preference?

Well, that's the right place if you want me to merge it, which seems to
be what Marcelo is also expecting...

However I do wonder why is that expectation there in the first place and
why aren't those handled by the crypto maintainer...

Cheers,
Ben.
