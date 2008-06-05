Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5629DEA94
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:46:33 +1000 (EST)
In-Reply-To: <fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <459415320e72f1bd92d036b29c80baae@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Thu, 5 Jun 2008 17:46:15 +0200
To: "Grant Likely" <grant.likely@secretlab.ca>
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

>> I think we should just expand the definition of cell-index to include 
>> standard
>> device enumeration for when it's needed.  The original definition is 
>> too
>> limited, IMHO.
>
> nak
>
> if you need explicit indexing then use an alias.  My opinion however
> is that explicit indexing is unnecessary and is just an artifact of
> current i2c subsystem internals.  There is already enough information
> in the device tree to match i2c devices with i2c busses without
> resorting to indexes.

Fully agreed.  Let me say it as well, it makes me feel powerful:

NAK


Segher
