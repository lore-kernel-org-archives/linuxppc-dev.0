Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87F45DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 13:24:58 +1000 (EST)
Subject: Re: [PATCH/RFC] net: Add __napi_sycnhronize() to sync with napi	poll
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <47157EA4.1000500@garzik.org>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
	<1192589522.11899.130.camel@pasglop>  <47157EA4.1000500@garzik.org>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 13:24:41 +1000
Message-Id: <1192591481.11899.134.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	Stephen Hemminger <shemminger@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

\
> > Note: unfortunately, Jeff already picked up the EMAC patch without
> > waiting for this to be sorted out (oops...). So if you agree with
> > this patch, it would be nice to have it go in quickly or maybe via
> > Jeff's tree to avoid breakage ? Not terribly important tho.
> 
> 
> Sorry, I thought that was the way everybody was headed.  With the driver 
> broken /anyway/, I just sorta threw it into the pile of fixes.
> 
> It's upstream now, so let me know if you want to revert or move forward 
> from here...

Let's just move forward. I can always re-fix the driver :-)

Ben.
