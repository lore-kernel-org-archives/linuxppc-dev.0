Return-Path: <BATV+54e4ee8a974e2d9aaca0+2375+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42B47B7D1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Feb 2010 23:48:31 +1100 (EST)
Subject: Re: [PATCH 2/4] Fix G5 thermal shutdown
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1265676905.8287.254.camel@pasglop>
References: <20100205133552.GF12001@hansolo.jdub.homelinux.org>
	<20100205135216.GH12001@hansolo.jdub.homelinux.org>
	<1265676905.8287.254.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Feb 2010 12:48:04 +0000
Message-ID: <1266929284.30247.2581.camel@macbook.infradead.org>
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

On Tue, 2010-02-09 at 11:55 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2010-02-05 at 08:52 -0500, Josh Boyer wrote:
> > This changes the thresholds for the liquid cooled G5 thermal
> > shutdown mechanism to prevent an errant shutdown.
> > 
> > This has been carried since about Fedora Core 5.  I have no idea
> > if it's really needed or not.

It's kind of a dirty hack, but it was sufficient to stop my machine
constantly powering itself off.

> Can we have a SoB ?

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
