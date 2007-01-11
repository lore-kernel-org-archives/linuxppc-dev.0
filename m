Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11048DDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 03:56:50 +1100 (EST)
In-Reply-To: <528646bc0701110820r77aa7bb6oe44904da3f6841e8@mail.gmail.com>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
	<528646bc0701110750m15cd0f01xe014f75a2c9db625@mail.gmail.com>
	<528646bc0701110820r77aa7bb6oe44904da3f6841e8@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f55fb6323064c1d4008b0ed1b02d8c64@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Date: Thu, 11 Jan 2007 17:57:16 +0100
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Sylvain and I just discussed this a bit.  Since gpt0 is different (has
> the watchdog bits) it should have a compatible property that reflects
> it.  We're thinking about adding "mpc52xx-wdt" to the compatible list
> for gpt0.

Or add an extra (empty) property "has-watchdog" or
something like that.


Segher
