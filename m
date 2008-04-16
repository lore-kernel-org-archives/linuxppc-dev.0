Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51ABCDE69F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 00:02:54 +1000 (EST)
Subject: Re: Please pull 'for-2.6.26' branch of 4xx tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080416084349.3c9997f1@zod.rchland.ibm.com>
References: <20080415102704.39511160@zod.rchland.ibm.com>
	<20080416072758.092c83c5@zod.rchland.ibm.com>
	<20080416073139.7f56e72c@zod.rchland.ibm.com>
	<1208350247.6958.283.camel@pasglop>
	<20080416084349.3c9997f1@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 00:02:47 +1000
Message-Id: <1208354567.6958.289.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-16 at 08:43 -0500, Josh Boyer wrote:
> 
> For a final solution, we're going to have to come up with a more
> clever
> way of doing the clocking stuff in ibm_newemac.  The SDRs are board
> specific and completely outside of EMAC/MAL itself.  So doing a
> dcr_map

Not board specific... chip specific.

> on it becomes a bit more difficult, since there really isn't an SDR
> node in the device tree at the moment.

That is why I tried hard to avoid the bloody workarounds...
unfortunatly, the HW is crap enough that we have no real choice here.

Ben.
 
