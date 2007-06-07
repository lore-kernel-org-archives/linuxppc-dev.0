Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A54A2DDEBA
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 12:55:58 +1000 (EST)
Date: Wed, 6 Jun 2007 21:55:49 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Philippe Lachenal" <philippe.lachenal@hotmail.fr>
Subject: Re: MPC8349ea Random Device Generator driver
Message-Id: <20070606215549.02ff8084.kim.phillips@freescale.com>
In-Reply-To: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sl@powerlinux.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 05 Jun 2007 17:42:08 +0200
"Philippe Lachenal" <philippe.lachenal@hotmail.fr> wrote:

> Hello !
> 
> I've made a driver for the MPC8349ea Random Device Generator, and I 
> therefore submit it to your impartial judgment.. ;)
> thanks a lot !
> 
> Lachenal Philippe
> 

the Random Device Generator, eh?  didn't know we had one of those. ;)

The RNG h/w block in question shares registers, initialization and
configuration with what's known as the Freescale SEC device (a.k.a.
talitos).  Talitos does crypto and public key ops, and some
implementations don't have an RNG EU.  There needs to be one driver for
the SEC, and it's not an rng driver.

Kim
