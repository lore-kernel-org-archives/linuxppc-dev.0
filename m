Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35F55DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 08:00:16 +1000 (EST)
In-Reply-To: <20070727164047.GB26893@ld0162-tx32.am.freescale.net>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<20070727164047.GB26893@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dfa3ff8d8c6af28003c7f9f831371358@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Wed, 1 Aug 2007 00:00:06 +0200
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

> Naming devices for human consumption is a more general problem than
> device-id addresses; I'd like to see a standard "label" property added 
> to
> the device tree spec that software could use to present a 
> human-friendly
> label that corresponds to markings on the case, position on the board,
> etc.

For some buses, there is a "slot-names" property; some (non-core)
bindings seem to define a "location" property.

For "random" human-readable labelling, i.e. not corresponding to
physical markings on the hardware, I recommend you look for a
matching entry in /aliases.  It won't ever be _exactly_ what you
want though, the Linux device namespace is separate from the
device tree.


Segher
