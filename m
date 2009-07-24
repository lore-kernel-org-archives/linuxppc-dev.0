Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4A054B7BA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 20:35:42 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A683FDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jul 2009 20:35:41 +1000 (EST)
Subject: Re: [PATCH 0/5] Generic NVRAM support for large MMIO devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <4A697E22.2080609@gefanuc.com>
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<1248335077.3367.79.camel@pasglop>  <4A697E22.2080609@gefanuc.com>
Content-Type: text/plain
Date: Fri, 24 Jul 2009 20:35:26 +1000
Message-Id: <1248431726.25467.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> I'm not aware of a maintainer for the "generic nvram" driver. As 
> mentioned in my other email, I'm fairly confident that this driver 
> (/drivers/char/generic_nvram.c) is only used on PowerPC. I'm beginning 
> to enter what is for me uncharted territory :-) How should I proceed? 
> Are you happy to take the entire patch series, do I send the entire 
> patch series to Andrew and LKML or just patch 2/5?

I'll dbl check, if it's only ppc then I'll take the whole series,

As usual, if you don't see things happening by end of next week, ping
me :-) But it's on patchwork so hopefully it won't fall through the
cracks.

Cheers,
Ben.
