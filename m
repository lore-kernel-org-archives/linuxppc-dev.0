Return-Path: <benh@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <463A27A6.5050601@ru.mvista.com>
References: <20070501051804.GB3881@localhost.localdomain>
	<4639CBD8.6010205@ru.mvista.com>
	<20070503123055.GE26659@localhost.localdomain>
	<4639DDE1.40904@ru.mvista.com>
	<71e4c68de5240a652b561d8cfa2e05f3@kernel.crashing.org>
	<463A1941.3090608@ru.mvista.com>
	<4e36fd0fc67f14fc4ff2178468c053f0@kernel.crashing.org>
	<463A27A6.5050601@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 04 May 2007 07:44:33 +1000
Message-Id: <1178228673.6353.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>     UARTs should be registered as of_device by the same bus probing mechanism 
> (and there was an attempt at OF based driver, IIRC). 

There is more than an "attempt". There is one and it works :-)

> arch/powerpc/kernel/legacy_serial.c only facilitates the old, platform device 
> based approach.

This is a compromise for legacy port (ok, it did grow a bit beyond
legacy stuff but still...) mostly to allow for very early initialisation
of serial ports.

Ultimately, if we generalize of_platform_devices for serial ports,
however, we will not need to create platform devices there anymore.

Ben.
