Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA83DDE010
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 13:21:29 +1000 (EST)
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Add PLB support and cleanup
	DCR in xilinxfb driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
In-Reply-To: <20090517122644.f537f500.krzysztof.h1@poczta.fm>
References: <20090515181237.22961.64270.stgit@localhost.localdomain>
	<20090517100643.9d00e980.krzysztof.h1@poczta.fm>
	<10f740e80905170125ie1c1aew441de30874e6a72f@mail.gmail.com>
	<20090517122644.f537f500.krzysztof.h1@poczta.fm>
Content-Type: text/plain
Date: Mon, 18 May 2009 13:20:54 +1000
Message-Id: <1242616854.18075.24.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Antonino Daplas <adaplas@gmail.com>, Suneel <suneelg@xilinx.com>,
	linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2009-05-17 at 12:26 +0200, Krzysztof Helt wrote:

> If so please ignore my comment.
> 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Andrew, will you merge this or should I stick it into the powerpc.git
tree ?

Cheers,
Ben.
