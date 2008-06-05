Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B35BDE783
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:21:59 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55GLtuh020853
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 12:21:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55GLsVh097054
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 10:21:54 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55GLhTX029836
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 10:21:44 -0600
Date: Thu, 5 Jun 2008 11:21:22 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605112122.0381a338@zod.rchland.ibm.com>
In-Reply-To: <484810A3.5070301@freescale.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 05 Jun 2008 11:13:23 -0500
Timur Tabi <timur@freescale.com> wrote:

> Grant Likely wrote:
> 
> > That is still Linux internal artifacts leaking out.  Don't encode that
> > data into the device tree.
> 
> The I2C bus number is *not* an internal artifact.  On Freescale parts, the one
> I2C adapter is specifically designated I2C1, and the 2nd one is specifically
> designated I2C2.  This is part of the silicon, and so the device tree should
> specify it.

And it does.  It does so by the unique "regs" properties and
unit-names.  You can assign the index that the i2c subsystem needs
based on probe order, like I already said.

I don't know why Jean doesn't like that.  It's not a made up number.

josh
