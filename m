Return-Path: <benh@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4639CF44.6020608@ru.mvista.com>
References: <20070501051804.GB3881@localhost.localdomain>
	<20070503103534.63ff67b6@localhost.localdomain>
	<20070503070358.GA9430@localhost.localdomain>
	<4639CF44.6020608@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 22:29:13 +1000
Message-Id: <1178195353.6353.38.camel@localhost.localdomain>
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


>     It doesn't seem a flexible enough approach. We could continue using 
> platform devices then.

The problem is trivial enough tho... who ends up creating an
of_platform_device for that rom node ... to be picked up by the driver.

Creating of_platform devices is platform code responsibility... either
by calling of_platform_bus_probe() (or whatever I called it ...) to
generate them from known bus type or by creating them directly, that
doesn't matter, that's still platform code business.

Ben.
