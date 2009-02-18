Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 570ACDDDB6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 03:57:29 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1IGvPcw025782
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 09:57:26 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1IGvPoa005488
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 10:57:25 -0600 (CST)
Date: Wed, 18 Feb 2009 10:57:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: Regarding irq_of_parse_and_map
Message-ID: <20090218165724.GA26391@ld0162-tx32.am.freescale.net>
References: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>
	<20090216180857.GA18069@ld0162-tx32.am.freescale.net>
	<f234e2140902170341y31662e8fla8a8cf87473ed419@mail.gmail.com>
	<499AF08B.6010702@freescale.com>
	<f234e2140902180401u40a71642ga4e221f795bc5abd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f234e2140902180401u40a71642ga4e221f795bc5abd@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 18, 2009 at 05:31:34PM +0530, Vijay Nikam wrote:
> > Don't specify this explicitly.  Please base new development off of the
> > device tree that is in upstream Linux, not the very old tree in your BSP.
> 
> May I know the reason why I should not specify it explicitly ? ? ?

Because dtc will generate phandles automatically when you reference the
node with the & operator.

> Also what would be the problem if I do in the same way as it is given
> in BSP mpc8313erdb.dts ? ? ?

Do you want your changes to ever make it into the upstream kernel?

> And should I use gpio-controller as a gpio device node ? ? ?

Yes, the node should label itself as a gpio controller.

-Scott
