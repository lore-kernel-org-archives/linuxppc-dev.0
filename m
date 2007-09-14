Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2F1BDDD05
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 23:25:48 +1000 (EST)
In-Reply-To: <7a05156b54e7de9c2c24a146e7826699@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<7a05156b54e7de9c2c24a146e7826699@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8C6E33B3-5816-4AA5-8AA8-37618F6A610A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 04/22] [POWERPC] Update mpc7448hpc2 device tree to be
	compatible for tsi109 chip
Date: Fri, 14 Sep 2007 08:28:41 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2007, at 5:54 PM, Segher Boessenkool wrote:

>> Update mpc7448hpc2 device tree to be compatible for tsi109 chip.
>
> Do all those boards have a tsi109?  If not, this patch is
> incorrect.  If they do, is tsi109 actually backward-compatible
> to tsi108?  That is, will a driver that knows about tsi108
> only work correctly on a tsi109?

I believe its a tsi108 and thus am going to drop this patch since I  
agree with you.  Unless Roy tells me otherwise.

> Also, all those names really should have a manufacturer
> prefix ("XXX,...").

More cleanup for someone :)

- k
