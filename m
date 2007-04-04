Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 390D0DDEC6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:33:41 +1000 (EST)
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070403.181733.27782389.davem@davemloft.net>
References: <20070403.170212.02298297.davem@davemloft.net>
	<1175645568.10567.42.camel@shinybook.infradead.org>
	<1175649192.30879.19.camel@localhost.localdomain>
	<20070403.181733.27782389.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 11:32:42 +1000
Message-Id: <1175650362.30879.43.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: paulus@samba.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 18:17 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 04 Apr 2007 11:13:12 +1000
> 
> > It worked before the new serial core, we had a "tweak" in the old 8250
> > driver to be able to share minors, but that got busted when Russell
> > rewrote the whole thing. I remember asking him back when he still was
> > the serial maintainer, and he refused to bring back some sharing of
> > minors.
> 
> Fork the 8250 driver like I did on Sparc so you can get the
> dynamic minor behavior back :-))))

heh, maybe I can use your forked/sparc version :-)

Ben.
