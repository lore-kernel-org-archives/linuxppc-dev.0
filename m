Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E80CCDE29C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 11:19:25 +1100 (EST)
Date: Mon, 05 Jan 2009 16:19:26 -0800 (PST)
Message-Id: <20090105.161926.141190504.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] net/ehea: use consistent type
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090106110511.43b0a87a.sfr@canb.auug.org.au>
References: <20081230.215101.228854586.davem@davemloft.net>
	<1230714541.15389.69.camel@pasglop>
	<20090106110511.43b0a87a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Jan 2009 11:05:11 +1100

> Hi Dave,
> 
> On Wed, 31 Dec 2008 20:09:01 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Well, in that case, this patch is actually correct without considering
> > the u64 change. The array is what lands in the registers of the pHyp
> > call, so strictly speaking, it's an array of unsigned long's (ie, 32-bit
> > on a 32-bit platform, 64-bit on a 64-bit platform), not an array of
> > u64's. This function being a wrapper on that pHyp call, it may as well
> > use the right type.
> 
> So, any response?

Please resubmit, I'll take another look :-)
