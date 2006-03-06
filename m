Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6668367B2C
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2006 18:41:16 +1100 (EST)
In-Reply-To: <20060306073834.GA24869@suse.de>
References: <20060304191026.GA9815@suse.de>
	<200603061212.12815.michael@ellerman.id.au>
	<20060306073834.GA24869@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <590CA2B3-AACE-4B69-930D-9A66A42FFC83@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] return to OF via trap, not exit
Date: Mon, 6 Mar 2006 08:41:36 +0100
To: Olaf Hering <olh@suse.de>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Which is likely ok because it saves us from typing .registers  
> manually.

I can't say that's a great argument.  How about doing the trap thing
on "known-bad" platforms only?


Segher
