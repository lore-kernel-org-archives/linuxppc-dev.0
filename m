Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B3A3DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 14:56:58 +1100 (EST)
Message-Id: <B8D9D613-441B-4A20-AE2D-D808D4B82F16@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
In-Reply-To: <47B35ED8.7020404@ru.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Enable correct operation of serial ports with
	nonzero regshift.
Date: Wed, 13 Feb 2008 21:56:52 -0600
References: <47B35ED8.7020404@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2008, at 3:19 PM, Pavel Kiryukhin wrote:

> Add regshift reading to serial drivers.
> This enables correct operation of serial ports with nonzero regshift.

what device needs this?

- k
