Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D4F04767E
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:06:11 +1000 (EST)
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080821.144545.54542588.davem@davemloft.net>
References: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<20080821.144545.54542588.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 22 Aug 2008 08:05:50 +1000
Message-Id: <1219356350.21386.150.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-21 at 14:45 -0700, David Miller wrote:
> > As far as I can tell from poking around 
> > http://penguinppc.org/historical/dev-trees-html/, they don't include
> reg 
> > at all for i2c clients.
> 
> That actually simplifies things for us, thanks for checking.

Unfortunately, while that may be true for old stuff, most recent
powermacs do. Encoding is mostly like sparc though (see other mails).

Ben.
