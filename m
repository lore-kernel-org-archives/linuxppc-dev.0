Return-Path: <Catalin.Marinas@arm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 82B4CB708A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 03:52:29 +1000 (EST)
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
	[193.131.176.58]) by ozlabs.org (Postfix) with ESMTP id A352EDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 03:52:27 +1000 (EST)
Subject: Re: [PATCH] kmemleak: Allow kmemleak to be built on powerpc
From: Catalin Marinas <catalin.marinas@arm.com>
To: michael@ellerman.id.au
In-Reply-To: <1247730230.18228.5.camel@concordia>
References: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
	<1247730230.18228.5.camel@concordia>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 18:52:19 +0100
Message-Id: <1247766739.27689.63.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-16 at 17:43 +1000, Michael Ellerman wrote:
> On Thu, 2009-07-16 at 11:25 +1000, Michael Ellerman wrote:
> > Very lightly tested, doesn't crash the kernel.
> > 
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> > 
> > It doesn't look like we actually need to add any support in the
> > arch code - or is there something I'm missing?
> 
> Hmm, I think we want to add annotations in lib/lmb.c don't we? That's
> our low-level pre-bootmem allocator.

Yes, I think so (I'm not using this on ARM or x86 so I can't really test
it). Without these hooks, there kmemleak reports aren't that useful
(probably too many).

-- 
Catalin
