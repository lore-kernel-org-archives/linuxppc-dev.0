Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 16897DE066
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 07:31:18 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RFC] CPM1: implement GPIO API
Date: Thu, 13 Dec 2007 21:31:11 +0100
References: <47600F5E.8060907@scram.de>
	<20071213165530.GB4347@loki.buserror.net>
In-Reply-To: <20071213165530.GB4347@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712132131.11835.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 13 December 2007, Scott Wood wrote:
> > +}
> > +EXPORT_SYMBOL_GPL(gpio_request);
> 
> This is an API, not internals; can we stick with plain EXPORT_SYMBOL()?

The architecture independent API posted by David Brownell uses _GPL,
see http://lkml.org/lkml/2007/11/9/141.

I'd vote for _GPL on all new interfaces anyway, but I guess this one
is really David's decision since he came up with the API.

	Arnd <><
