Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 777D0DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 12:31:52 +1100 (EST)
Subject: Re: [PATCH 0/3] PowerPC: ibm_newemac minor fixes.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <47477C55.8090209@garzik.org>
References: <20071123190747.GA25654@ru.mvista.com>
	<1195867102.7195.31.camel@pasglop>  <47477C55.8090209@garzik.org>
Content-Type: text/plain
Date: Sat, 24 Nov 2007 12:31:34 +1100
Message-Id: <1195867894.7195.40.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-23 at 20:20 -0500, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> > On Fri, 2007-11-23 at 22:07 +0300, Valentine Barshak wrote:
> > 
> >> These patches have some minor ibm_newemac fixes.
> > 
> > All 3 patches look good, thanks. I'll sign them off and forward them
> > to Jeff in my next batch.
> > 
> > Jeff, did you already pick up my previous drop of EMAC patches from last
> > week for .25 or not ? If not, I will resend the whole lot along with
> > Valentine's patches sometime next week.
> 
> Just got back from Thanksgiving holiday, and am about to go through the 
> lot that's sitting in my inbox.
> 
> Just let me know what you would prefer me to do, starting from today.

Then wait for my next batch and ignore previous patches, except the
one titled "ibm_newemac: Fix possible lockup on close" which is a 2.6.24
bug fix.

Thanks !

Cheers,
Ben.
