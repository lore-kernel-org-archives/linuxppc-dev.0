Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10AACDDE27
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 04:40:41 +1100 (EST)
Date: Fri, 21 Dec 2007 11:40:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/4] sbc8560: Add device tree source for Wind River
	SBC8560 board
Message-ID: <20071221174033.GA7174@ld0162-tx32.am.freescale.net>
References: <442fe9c9343f3c694932bcdc5f819c493c33c76b.1198107769.git.paul.gortmaker@windriver.com>
	<6be237dcf5b58d604afa6cea3079ec7de02a8de9.1198107769.git.paul.gortmaker@windriver.com>
	<20071220235724.GA2665@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071220235724.GA2665@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 10:57:24AM +1100, David Gibson wrote:
> > +		mpic: pic@40000 {
> > +			clock-frequency = <0>;
> 
> The mpic has a clock-frequency??

Yes, there's a timer on the PIC.

> > +			interrupt-controller;
> > +			#address-cells = <0>;
> 
> Should have #size-cells = <0> too.

This is debatable. :-)

-Scott
