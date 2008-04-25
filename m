Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6FC7DDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 16:04:32 +1000 (EST)
Message-ID: <4811746B.9050202@pobox.com>
Date: Fri, 25 Apr 2008 02:04:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ibm_newemac: Increase MDIO timeouts
References: <20080423051832.63BF7DDF65@ozlabs.org>
In-Reply-To: <20080423051832.63BF7DDF65@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: super.firetwister@googlemail.com, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> This patch doubles the MDIO timeouts in EMAC as there are field
> cases where they are two short to communicate with some PHYs.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

applied
