Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1B6BDDF4E
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 07:47:05 +1000 (EST)
Message-ID: <4862BCCF.6040403@freescale.com>
Date: Wed, 25 Jun 2008 16:46:55 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>	
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>	
	<20080604211942.2bddc860@zod.rchland.ibm.com>	
	<4848028B.5060105@freescale.com>	
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>	
	<48480987.1070701@freescale.com>
	<1212726040.12464.21.camel@pasglop>
In-Reply-To: <1212726040.12464.21.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
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

Benjamin Herrenschmidt wrote:

> No, the fabric driver should get to its device node in a way or another,
> and from there, find a pointer (via a phandle) to it's codec, and match
> that to an i2c device.
> 
> If the current infrastructure doesn't allow that kind of matching, it
> needs to be fixed.

Scott and I looked at this just now, and it doesn't seem to be an easy fix
unless we use of_i2c.c, which seems to be unused currently.  Something about not
being able to get the i2c_adapter structure from its corresponding device_node
struct.

Anyone know when of_i2c.c is going to come "online" replace what's in fsl_soc.c?

-- 
Timur Tabi
Linux kernel developer at Freescale
