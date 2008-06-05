Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E7C6DF881
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 05:15:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55JFVZO008242
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 15:15:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55JFNn6103906
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 13:15:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55JFMTn014741
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 13:15:23 -0600
Date: Thu, 5 Jun 2008 14:15:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605141500.4cb4181d@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40806051214u6866cec0m66ea32275d8bd5cc@mail.gmail.com>
References: <200806041706.21557.sr@denx.de>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
	<20080605132735.3433f2af@zod.rchland.ibm.com>
	<fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>
	<20080605135625.562d1dbe@zod.rchland.ibm.com>
	<fa686aa40806051214u6866cec0m66ea32275d8bd5cc@mail.gmail.com>
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

On Thu, 5 Jun 2008 13:14:00 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Thu, Jun 5, 2008 at 12:56 PM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > On Thu, 5 Jun 2008 12:46:39 -0600
> > "Grant Likely" <grant.likely@secretlab.ca> wrote:
> >
> >> In Timur's case, it is absolutely appropriate to use cell-index and/or
> >> a phandle to make sure it gets the correct DMA registers (which is
> >> what cell-index is intended to solve).  It is not appropriate to
> >> depend on that same number to also be the logical i2c bus number.
> >
> > Hence "index" would be a better fit for the latter then, yes?
> >
> 
> No; use an alias in the aliases node.  That is what aliases is designed
> for.  Something like 'index' is a reinvention of the wheel.

Ah.  Good point.

josh
