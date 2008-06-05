Return-Path: <sean.maclennan@pikatech.com>
Received: from mail.pikatech.com (mail.pikatech.com [207.107.229.10])
	by ozlabs.org (Postfix) with ESMTP id E7F4EDE11A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 08:45:41 +1000 (EST)
Received: from [207.107.229.5] (helo=pks00005.kanatek.com)
	by mail.pikatech.com with esmtp (Exim 4.51) id 1K4OAc-0005wS-Jc
	for linuxppc-dev@ozlabs.org; Thu, 05 Jun 2008 18:42:58 -0400
Date: Thu, 5 Jun 2008 18:45:09 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605184509.1e788220@wally.pikatech.com>
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

> No; use an alias in the aliases node.  That is what aliases is
> designed for.  Something like 'index' is a reinvention of the wheel.

If we really want to get rid of the index, I like the alias method. I
mainly write drivers, so I don't know register addresses. I just read
the spec and it says device A is on i2c bus 2. That is why I went with
the index. Calling get_i2c_apapter(2) makes sense.

However, calling get_i2c_adapter("IIC2"), just as a made up example,
makes just as much sense.

Cheers,
   Sean
