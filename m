Return-Path: <fin@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD4362C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 08:17:03 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fin@linux.vnet.ibm.com>;
 Fri, 2 Aug 2013 23:17:01 +0100
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C90356E803A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 18:16:53 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72MGwg038994150
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 18:16:58 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r72MGwaL014698
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 18:16:58 -0400
Message-ID: <1375481816.32477.22.camel@what-is-leg>
Subject: Re: [PATCH] drivers/crypto/nx: saves chaining value from co-processor
From: Fionnuala Gunter <fin@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 02 Aug 2013 17:16:56 -0500
In-Reply-To: <1375480754.15999.42.camel@pasglop>
References: <1375477090.32477.10.camel@what-is-leg>
 <1375477741.15999.23.camel@pasglop> <1375480550.32477.19.camel@what-is-leg>
 <1375480754.15999.42.camel@pasglop>
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

On Sat, 2013-08-03 at 07:59 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-02 at 16:55 -0500, Fionnuala Gunter wrote:
> > Sorry, I thought linuxppc-dev was the right tree since the patch is
> > for
> > a ppc driver and you've carried previous nx driver submissions
> > upstream. 
> > 
> > I want to submit to the proper place, so what is your preference?
> 
> Well, that's the right place if you want me to merge it, which seems to
> be what Marcelo is also expecting...

Please merge this patch, it fixes a hot bug.

> However I do wonder why is that expectation there in the first place and
> why aren't those handled by the crypto maintainer...

In the future I can submit patches to the crypto maintainer.

-Fin
