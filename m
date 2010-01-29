Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92791B7CD7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 14:54:42 +1100 (EST)
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20100129034524.GA13385@parisc-linux.org>
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>
	<20100125123849.111fa2d1@jbarnes-piketon>
	<20100125175025.4c74f412@jbarnes-piketon>
	<1264558256.3601.153.camel@pasglop>
	<20100129034524.GA13385@parisc-linux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Jan 2010 14:54:15 +1100
Message-ID: <1264737255.20211.45.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jay Vosburgh <fubar@us.ibm.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	David Miller <davem@davemloft.net>, Ron Mercer <ron.mercer@qlogic.com>,
	kaneshige.kenji@jp.fujitsu.com, linuxppc-dev@lists.ozlabs.org,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-01-28 at 20:45 -0700, Matthew Wilcox wrote:
> > This is also probably going to be moved to a more generic place and
> > extended to be used optionally by other architectures.
> 
> Yes, having it under drivers/pci/ somewhere would be a big improvement,
> that way we'd actually see it when trying to do cleanups and wouldn't
> accidentally break your architectures. 

Yup, and you'll notice that I didn't complain about the breakage for
that precise reason :-)

Cheers,
Ben.
