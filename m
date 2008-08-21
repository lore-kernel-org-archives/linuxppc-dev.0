Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99399DFB23
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:38:37 +1000 (EST)
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080821.152701.261427328.davem@davemloft.net>
References: <48ADDF86.2040200@freescale.com>
	<20080821.144545.54542588.davem@davemloft.net>
	<1219356350.21386.150.camel@pasglop>
	<20080821.152701.261427328.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 22 Aug 2008 08:38:23 +1000
Message-Id: <1219358303.21386.155.camel@pasglop>
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


> Thanks for the clarification.  The bus encoding seems different
> but we can solve that too.
> 
> I've started a dialogue between Scott and the openfirmware Sun
> folks I know so that hopefully Scott can get a copy of the I2C
> bindings Sun uses and we can sort all of this out.

Sure. Currently the powermac stuff isn't too relevant because I
use my own infrastructure (not a huge thing, but I have a special
layer of low level polled i2c drivers that I can use early during
boot or during low level suspend/resume with IRQs off etc... that
hooks up on to the main linux i2c stack etc...)

So I'll let you guys come up with something, and we can later see if
there's any interest in moving some of the pmac stuff over to it.

Ben.
