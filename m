Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C017DE128
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 15:33:17 +1000 (EST)
Subject: Re: Musings on PCI busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090519.120514.26253637.davem@davemloft.net>
References: <fa686aa40905190828x251765dek586f5bf8e73e4cf7@mail.gmail.com>
	<200905191812.03347.arnd@arndb.de>
	<20090519.120514.26253637.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 20 May 2009 15:33:03 +1000
Message-Id: <1242797583.16901.136.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com,
	arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-05-19 at 12:05 -0700, David Miller wrote:
> 
> This is also what sparc64 does :-)
> 
> All of the individual sparc64 PCI controller types have a OF driver
> and then there is a common layer of OF PCI helper code to do most
> of the work.

I agree it's a good idea in the long run, but on ppc32, I would be a bit
careful due to the amount of historical crap & early board fixup we have
that may need working PCI config space accesses and make assumption
about when PCI is probed.

We could add the necessary bits for ppc32 to be able to "opt-in" the new
scheme on a per board basis I suppose.

Cheers,
Ben.
