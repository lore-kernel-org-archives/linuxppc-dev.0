Return-Path: <billfink@mindspring.com>
Received: from elasmtp-galgo.atl.sa.earthlink.net
	(elasmtp-galgo.atl.sa.earthlink.net [209.86.89.61])
	by ozlabs.org (Postfix) with ESMTP id ABEBBDDFA7
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 06:57:16 +1000 (EST)
Date: Fri, 25 Apr 2008 16:57:03 -0400
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ibm_newemac: Increase MDIO timeouts
Message-Id: <20080425165703.864e63bd.billfink@mindspring.com>
In-Reply-To: <20080423051832.63BF7DDF65@ozlabs.org>
References: <20080423051832.63BF7DDF65@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: super.firetwister@googlemail.com, netdev@vger.kernel.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Apr 2008, Benjamin Herrenschmidt wrote:

> This patch doubles the MDIO timeouts in EMAC as there are field
> cases where they are two short to communicate with some PHYs.

I guess them being "two short" is why they needed to be doubled.  :-)

						-Bill
