Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6BD71007E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:54:56 +1000 (EST)
Subject: Re: [PATCH 6/7] powerpc/mm: 64-bit: tlb handler micro-optimization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110518165134.1023dccc@schlenkerla.am.freescale.net>
References: <20110518210536.GE29524@schlenkerla.am.freescale.net>
	<1305754667.7481.5.camel@pasglop>
	<20110518165134.1023dccc@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:54:48 +1000
Message-ID: <1305755688.7481.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-18 at 16:51 -0500, Scott Wood wrote:
> On Thu, 19 May 2011 07:37:47 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> > > A little more speed up measured on e5500.
> > > 
> > > Setting of U0-3 is dropped as it is not used by Linux as far as I can
> > > see.
> > 
> > Please keep them for now. If your core doesn't have them, make them an
> > MMU feature.
> 
> We have them, it was just an attempt to clean out unused things to speed up
> the miss handler.  I'll drop that part if you think we'll use it in the
> future.

I never know for sure ... damn research people ... :-)

I'd rather keep them for now, does it make a significant difference ?

Cheers,
Ben.
