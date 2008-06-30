Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64863DDF24
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 04:46:34 +1000 (EST)
Message-ID: <486929E0.3060608@freescale.com>
Date: Mon, 30 Jun 2008 13:45:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] mpc7448hpc2.dts: remove chosen node from dts
References: <1214795032.9125.7.camel@pek-cluo>
	<34080997e6c29d809a38331f88caf3cf@kernel.crashing.org>
In-Reply-To: <34080997e6c29d809a38331f88caf3cf@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, chunbo.luo@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> Modern versions of u-boot create a chosen node automatically.  So if
>> we set the chosen node in the dts file, there will be 2 chosen nodes
>> passed in to the kernel,
> 
> That's a bug in uboot, then:

Yes, and it was fixed a while ago.

-Scott
