Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2DF8DDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 00:41:01 +1000 (EST)
In-Reply-To: <20070718013611.GY15238@ld0162-tx32.am.freescale.net>
References: <20070718013611.GY15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1F08B8A7-72C7-4963-96B6-3A73D04F3194@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 53/61] 82xx: Set NOT_COHERENT_CACHE on 8272 with PCI.
Date: Thu, 19 Jul 2007 16:40:52 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I've seen significant network corruption on a PCI network
> card (e1000) with the mpc8272ads; the corruption went away
> when I set CONFIG_NOT_COHERENT_CACHE.

That doesn't mean it's the correct fix.  Any idea what the
root cause is?

If you want this patch as a workaround, please document it
in the source code.


Segher
