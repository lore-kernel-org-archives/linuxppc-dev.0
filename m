Return-Path: <arnon.kaufman@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by ozlabs.org (Postfix) with ESMTP id AAEE2DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 04:28:46 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so1100338fkz.9
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 09:28:44 -0800 (PST)
Message-ID: <47656048.7060809@gmail.com>
Date: Sun, 16 Dec 2007 19:28:40 +0200
From: Arnon Kaufman <arnon.kaufman@gmail.com>
MIME-Version: 1.0
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [MPC5200] problem running FEC and ATA
References: <47652712.60006@gmail.com> <20071216154458.GZ3851@pengutronix.de>
In-Reply-To: <20071216154458.GZ3851@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Schwebel wrote:
> On Sun, Dec 16, 2007 at 03:24:34PM +0200, Arnon Kaufman wrote:
>> does any one succeed running a functional FEC and ATA (pata) running
>> together?
> 
> Yes, we do, on the phyCORE-MPC5200B-tiny; you can check our patches here:
> http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-tiny/
>

thanks, my kernels are already patched and still observing that kind of 
behavior. I'm using Domen's new FEC code and ATA from 2.6.24-rc2.

playing with the XLB Master's enable and priority lead to significant 
changes (good ones) in the rate of corruption appearance. I'm afraid of 
the "new" priority I've set, as that may lead to lockups on the XLB, 
still investigating.


> We've recently made the -6 release which supports ATA; although I'm not
> sure if the tests were done with networking & ATA at the same time I
> assume yes (at least while doing nfsroot). We'll re-check your scenario.
> 
> Note that there has been quite some activity wrt. MPC5200, bestcom and
> fec in the mainline recently. You should test the latest 2.6.24-rc
> kernel.
> 
> Robert
