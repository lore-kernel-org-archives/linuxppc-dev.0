Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.133.102.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 604C4B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 08:54:00 +1100 (EST)
Date: Wed, 9 Dec 2009 22:37:36 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cardbus: Add a fixup hook and fix powerpc
Message-ID: <20091209213736.GA25968@comet.dominikbrodowski.net>
References: <1260341533.16132.20.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1260341533.16132.20.camel@pasglop>
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

Hey Benjamin,

On Wed, Dec 09, 2009 at 05:52:13PM +1100, Benjamin Herrenschmidt wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net> (for PCMCIA)

> Note: In the long run we might want to streamline the hooks for fixing
> up new devices vs. new busses and make some stuff common between cardbus
> and PCI hotplug which is actually a mess.

... though I'd prefer such a generic approach.

Best,
	Dominik
