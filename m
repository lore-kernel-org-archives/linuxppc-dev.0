Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50A27DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 13:04:04 +1000 (EST)
Message-ID: <4719701A.2030805@pobox.com>
Date: Fri, 19 Oct 2007 23:03:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] phy/bitbang: missing MODULE_LICENSE
References: <20070920220043.GA28769@loki.buserror.net>	<20070920220123.GG28784@loki.buserror.net>
	<20071018122021.2acd128d.randy.dunlap@oracle.com>
In-Reply-To: <20071018122021.2acd128d.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Missing MODULE_LICENSE(), loading this module taints the kernel.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/net/phy/mdio-bitbang.c |    2 ++
>  1 file changed, 2 insertions(+)

applied this and the NAPI_Howto Kconfig patch
