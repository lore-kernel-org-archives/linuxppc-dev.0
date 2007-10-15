Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26F38DDEBF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 08:56:31 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9FMuRAw006421
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 18:56:27 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9FMuRfj332122
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 16:56:27 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9FMuQ3l006236
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 16:56:26 -0600
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support
	to NEW EMAC.
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1192482323.11795.38.camel@pasglop>
References: <20071015175717.GA4602@ru.mvista.com> <4713B10B.5000607@garzik.org>
	<20071015134813.6aacdcca@weaponx.rchland.ibm.com>
	<4713B726.6080404@garzik.org>
	<20071015135959.5b603d7d@weaponx.rchland.ibm.com>
	<4713B9C1.5010001@garzik.org>  <1192482323.11795.38.camel@pasglop>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 17:47:26 -0500
Message-Id: <1192488446.13993.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-10-16 at 07:05 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-10-15 at 15:04 -0400, Jeff Garzik wrote:
> > I would ideally like a single active patch generator (even if they
> > are 
> > merely reviewed others work sometimes).
> > 
> > Outside of that, I'm hoping you and the other people listed making 
> > changes will self-organize without my help :)
> 
> Josh, do you want to be the central point / maintainer for it or do you
> want me to do it ? There's a lot of code from me in there and I did this
> fork in the first place so I have a pretty good idea of what's going on
> in this driver and what still needs to be done :-)

As always, you're welcome to it.  You probably don't want to own it long
term, but I'd appreciate the help for the time being.

josh
