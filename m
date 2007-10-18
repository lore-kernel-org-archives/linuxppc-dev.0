Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A57B9DDF3C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 10:21:59 +1000 (EST)
Message-ID: <4716A71F.5000102@garzik.org>
Date: Wed, 17 Oct 2007 20:21:51 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] fix EMAC driver for proper napi_synchronize API
References: <1192513792.19073.23.camel@pasglop>	
	<20071016115318.0fc36af3@freepuppy.rosehill>	
	<1192589522.11899.130.camel@pasglop> <47157EA4.1000500@garzik.org>	
	<1192591481.11899.134.camel@pasglop>	
	<20071017083107.6a1b1bd3@freepuppy.rosehill>
	<1192662843.6783.48.camel@pasglop>
In-Reply-To: <1192662843.6783.48.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	Stephen Hemminger <shemminger@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> The EMAC driver "fix" was merged by mistake before the dust had settled on
> the new napi synchronize interface (and before it got merged). The final
> version of that function is spelled without underscores.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

applied
