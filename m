Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A17E768A7B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 09:57:17 +1100 (EST)
Date: Tue, 7 Feb 2006 14:57:13 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: IBM_EMAC_PHY_RX_CLK_FIX depends on non-existing option 440GR
Message-ID: <20060207225713.GA6933@gate.ebshome.net>
References: <20060207221449.GB3524@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060207221449.GB3524@stusta.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2006 at 11:14:49PM +0100, Adrian Bunk wrote:
> Jean-Luc Leger <reiga@dspnet.fr.eu.org> reported the following:
> 
> from drivers/net/Kconfig:
> config IBM_EMAC_PHY_RX_CLK_FIX
>         bool "PHY Rx clock workaround"
>         depends on IBM_EMAC && (405EP || 440GX || 440EP || 440GR)
> -> maybe this is 440GP ?
> 
> 
> The non-existing CONFIG_440GR is also present in the driver itself.
> 
> Is this a typo or a not yet merged platform?

Not yet merged platform.

-- 
Eugene
