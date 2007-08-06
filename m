Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F339BDDEA0
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:15:49 +1000 (EST)
In-Reply-To: <200708051841.17471.arnd@arndb.de>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
	<200708050135.07753.arnd@arndb.de>
	<Pine.LNX.4.60.0708051600550.4120@poirot.grange>
	<200708051841.17471.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e8ffca0a9f533e4685f0573e72b90239@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Mon, 6 Aug 2007 21:15:34 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Another option altogether would be to allow the device node to
> specify the linux specific serial port flags in a separate property,
> like "linux,uart-port-flags" that contains the same flags that
> setserial can set from user space. That would also be useful
> if you want to specify UPF_MAGIC_MULTIPLIER on certain high-speed
> ports, because it cannot be autoprobed.

Such high-speed ports should simply use a proper "compatible"
entry.  Similarly with the problem at hand.


Segher
