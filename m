Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C244EB7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 14:53:28 +1100 (EST)
Subject: Re: [PATCH] cardbus: Add a fixup hook and fix powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
In-Reply-To: <20091209213736.GA25968@comet.dominikbrodowski.net>
References: <1260341533.16132.20.camel@pasglop>
	<20091209213736.GA25968@comet.dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Dec 2009 14:53:16 +1100
Message-ID: <1260417196.16132.110.camel@pasglop>
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, blofeldus@yahoo.com,
	Olof Johansson <olof@lixom.net>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-09 at 22:37 +0100, Dominik Brodowski wrote:
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net> (for PCMCIA)
> 
> > Note: In the long run we might want to streamline the hooks for fixing
> > up new devices vs. new busses and make some stuff common between cardbus
> > and PCI hotplug which is actually a mess.
> 
> ... though I'd prefer such a generic approach. 

Thanks. Yes that would be better. I don't have the bandwidth right now
to look at that though, maybe early next year.

Cheers,
Ben.
