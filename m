Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 848911A0BE0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 17:59:21 +1000 (AEST)
Message-ID: <1438761561.20978.3.camel@neuling.org>
Subject: Re: [PATCH] cxl: Don't ignore add_process_element result when
 attaching context
From: Michael Neuling <mikey@neuling.org>
To: Daniel Axtens <dja@axtens.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 benh@kernel.crashing.org, imunsie@au.ibm.com
Date: Wed, 05 Aug 2015 17:59:21 +1000
In-Reply-To: <1438144834.28422.46.camel@axtens.net>
References: <1438142842-31603-1-git-send-email-dja@axtens.net>
 <1438143932.17434.1.camel@ellerman.id.au>
 <1438144834.28422.46.camel@axtens.net>
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

On Wed, 2015-07-29 at 14:40 +1000, Daniel Axtens wrote:
> On Wed, 2015-07-29 at 14:25 +1000, Michael Ellerman wrote:
> > On Wed, 2015-07-29 at 14:07 +1000, Daniel Axtens wrote:
> > > Previously, when attaching a context in dedicated mode, we ignored
> >=20
> > Previously? You mean currently? Now is before this patch is applied.
> I do mean currently. Apologies for the temporal confusion :)
>=20
> >=20
> > > the result of add_process_element, which could potentially fail.
> > >=20
> > > If add_process_element returns and error, pass it back to the caller.
> >                                    ^
> >=20
> > I can fix.
> >=20
> Many thanks: it's good to know that my spelling mistakes will only be
> immortalised in the list archives rather than in the kernel's git
> history. :p

Not to mention the double negative in the patch subject! "Don't
ignore"... come on!?!?  :-P

Mikey
