Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A611B6F01
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 15:33:19 +1000 (EST)
Subject: Re: linux support for freescale e5500 core?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <7EDBB1DD-BB9D-417D-8F4E-B9D5D9E030EF@kernel.crashing.org>
References: <4C9278CD.10607@genband.com>
	<20100916163911.6255d359@schlenkerla.am.freescale.net>
	<4C928FC5.9050700@genband.com> <1284674628.30449.98.camel@pasglop>
	<4C92998C.7000903@nortel.com> <1284681832.30449.101.camel@pasglop>
	<7EDBB1DD-BB9D-417D-8F4E-B9D5D9E030EF@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Sep 2010 15:33:05 +1000
Message-ID: <1284701585.30449.102.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Chris Friesen <chris.friesen@genband.com>,
	paulus@samba.org, Scott Wood <scottwood@freescale.com>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-09-17 at 00:17 -0500, Kumar Gala wrote:
> Not sure how the 970 bit worked, but this seems a bit problematic for
> switching between kernel and application for how we do this on
> e500mc/e5500.  We'd have to touch the control bit on every exception
> path which seems ugly to me.

Unless the kernel uses dcbzl (feature fixup replacement ?)

In that case it's on context switch only.

Cheers,
Ben.
