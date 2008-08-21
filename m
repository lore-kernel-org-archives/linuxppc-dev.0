Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id EC32247531
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:27:02 +1000 (EST)
Date: Thu, 21 Aug 2008 15:27:01 -0700 (PDT)
Message-Id: <20080821.152701.261427328.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1219356350.21386.150.camel@pasglop>
References: <48ADDF86.2040200@freescale.com>
	<20080821.144545.54542588.davem@davemloft.net>
	<1219356350.21386.150.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Aug 2008 08:05:50 +1000

> On Thu, 2008-08-21 at 14:45 -0700, David Miller wrote:
> > > As far as I can tell from poking around 
> > > http://penguinppc.org/historical/dev-trees-html/, they don't include
> > reg 
> > > at all for i2c clients.
> > 
> > That actually simplifies things for us, thanks for checking.
> 
> Unfortunately, while that may be true for old stuff, most recent
> powermacs do. Encoding is mostly like sparc though (see other mails).

Thanks for the clarification.  The bus encoding seems different
but we can solve that too.

I've started a dialogue between Scott and the openfirmware Sun
folks I know so that hopefully Scott can get a copy of the I2C
bindings Sun uses and we can sort all of this out.
