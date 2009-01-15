Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00976DE2D8
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 20:17:57 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id n0F9HoEr381258
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 09:17:50 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n0F9Ho743756208
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 10:17:50 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n0F9HnWb024374
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 10:17:50 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4 v2] hvc_console: remove tty->low_latency
Date: Thu, 15 Jan 2009 10:17:48 +0100
References: <hvc-console-29-3-1@bga.com> <1231880644.22571.47.camel@pasglop>
	<20090115091544.GC895@cetus.boeblingen.de.ibm.com>
In-Reply-To: <20090115091544.GC895@cetus.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901151017.48995.borntraeger@de.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Joe Peterson <joe@skyrush.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  drivers/char/hvc_console.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/drivers/char/hvc_console.c
> +++ b/drivers/char/hvc_console.c
> @@ -318,8 +318,6 @@ static int hvc_open(struct tty_struct *t
>  	} /* else count == 0 */
> 
>  	tty->driver_data = hp;
> -	if (!hp->irq_requested)
> -		tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
> 
>  	hp->tty = tty;
> 
> 

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
