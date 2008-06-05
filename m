Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E97B5DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 04:57:07 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55Iukfm001413
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 14:56:46 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55IukPn189296
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 14:56:46 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55IujHE007482
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 14:56:46 -0400
Date: Thu, 5 Jun 2008 13:56:25 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605135625.562d1dbe@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>
References: <200806041706.21557.sr@denx.de>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
	<20080605132735.3433f2af@zod.rchland.ibm.com>
	<fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 12:46:39 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> > (And I'm talking about I2C, not DMA.  I don't care about DMA because
> > this conversation will go off into the weeds if we start talking about
> > cell-index and every possible device out there.)
> 
> I need to disagree here.  Behavior should never be dependent on device
> tree order.  It should be absolutely fine for devices to be probed in
> a different order and different bus ids to be assigned.

Meh.  I'll begrudgingly agree.

> In Timur's case, it is absolutely appropriate to use cell-index and/or
> a phandle to make sure it gets the correct DMA registers (which is
> what cell-index is intended to solve).  It is not appropriate to
> depend on that same number to also be the logical i2c bus number.

Hence "index" would be a better fit for the latter then, yes?

josh
