Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 705D61007D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:58:39 +1000 (EST)
Subject: Re: [PATCH 7/7] powerpc/e5500: set MMU_FTR_USE_PAIRED_MAS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110518165200.0d3e0188@schlenkerla.am.freescale.net>
References: <20110518210538.GF29524@schlenkerla.am.freescale.net>
	<1305754699.7481.6.camel@pasglop>
	<20110518165200.0d3e0188@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 May 2011 07:58:30 +1000
Message-ID: <1305755910.7481.14.camel@pasglop>
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

On Wed, 2011-05-18 at 16:52 -0500, Scott Wood wrote:
> On Thu, 19 May 2011 07:38:19 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Wed, 2011-05-18 at 16:05 -0500, Scott Wood wrote:
> > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > ---
> > > Is there any 64-bit book3e chip that doesn't support this?  It
> > > doesn't appear to be optional in the ISA.
> > 
> > Not afaik.
> 
> Any objection to just removing the feature bit?

Nope. Wasn't it added by Kumar in the first place ?

Cheers,
Ben.
