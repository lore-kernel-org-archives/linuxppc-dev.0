Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C1EEDE060
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:27:31 +1000 (EST)
Subject: Re: [PATCH] net: Add napi_sycnhronize() to sync with napi poll
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1192669323.13993.33.camel@localhost.localdomain>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
	<1192589522.11899.130.camel@pasglop> <47157EA4.1000500@garzik.org>
	<1192591481.11899.134.camel@pasglop>
	<20071017083107.6a1b1bd3@freepuppy.rosehill>
	<1192658654.6783.43.camel@pasglop>
	<1192669323.13993.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 11:26:22 +1000
Message-Id: <1192670782.12879.7.camel@pasglop>
Mime-Version: 1.0
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
	Roland Dreier <rdreier@cisco.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Stephen Hemminger <shemminger@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-17 at 20:02 -0500, Josh Boyer wrote:
> k, trying again, leaving the actual patch below.  In the above patch
> description, you still call it __napi_synchronize.  In the patch
> below,
> it's napi_syncronize.
> 
> I was just trying to point out to whomever commits this patch that the
> actual description should probably be fixed.

Yup, I noticed finally :-) I think whoever commits can fix it up (it's
likely that it's sch patch that gets commited anyway).

Ben.
