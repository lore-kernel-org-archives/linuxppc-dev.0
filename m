Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12D06DDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 05:31:50 +1000 (EST)
Message-ID: <469E6AA0.7030805@freescale.com>
Date: Wed, 18 Jul 2007 14:31:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 46/61] mpc885ads: Rework initialization.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013600.GR15238@ld0162-tx32.am.freescale.net>
	<20070718124402.18197206@localhost.localdomain>
	<469E4267.2040001@freescale.com>
	<20070718222455.423ee0ba@localhost.localdomain>
In-Reply-To: <20070718222455.423ee0ba@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
>>The conflict is in register space, not pins -- why would the smc1
>>pins matter?
> 
> ok, I may have confused this with something else.

Possibly the conflict between FEC2 and SMC2 (which is still done via 
kconfig option)?

-Scott
