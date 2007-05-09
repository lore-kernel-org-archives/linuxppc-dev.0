Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99F94DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 08:36:26 +1000 (EST)
Date: Thu, 10 May 2007 02:36:11 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Samuel Ortiz" <samuel@sortiz.org>
Subject: Re: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Message-ID: <20070510023611.3a1be1d9@localhost.localdomain>
In-Reply-To: <irUYA8PN.1178718371.1966580.samuel@sortiz.org>
References: <20070509145353.483896a1@localhost.localdomain>
	<irUYA8PN.1178718371.1966580.samuel@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9 May 2007 13:46:11 -0000
Samuel Ortiz wrote:

> >So to recap, similar handling path for similar SoC device existing
> >in current kernel for a while now, and working good.  
> 
> I'm sure it works good, but doing the whole RX path from an interrupt
> handler doesn't sound like the best thing to do, at least to me. And
> with a SIR IrDA device, you can afford to offload your interrupt
> processing to a BH, nobody will notice the difference in terms of
> performance.
> I'm not against your proposed implementation, but I just think there's
> a nicer way to achieve the same result.
May I ask to point to the code you're keeping in mind here?

I'm not going to touch this path or else the code will miss this merge window as well, 
but I'm going to keep improving it, and this rework might be useful not only for this particular driver,
but for similar kernel pieces too.


-- 
Sincerely, Vitaly
