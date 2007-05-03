Return-Path: <benh@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <a8625bde363025ce23393d5b2bb6ec07@kernel.crashing.org>
References: <20070501051804.GB3881@localhost.localdomain>
	<20070503103534.63ff67b6@localhost.localdomain>
	<20070503070358.GA9430@localhost.localdomain>
	<4639CF44.6020608@ru.mvista.com>
	<20070503122213.GD26659@localhost.localdomain>
	<4639E389.4040604@ru.mvista.com>
	<a8625bde363025ce23393d5b2bb6ec07@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 04 May 2007 07:37:53 +1000
Message-Id: <1178228273.6353.57.camel@localhost.localdomain>
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

On Thu, 2007-05-03 at 18:21 +0200, Segher Boessenkool wrote:
> >     BTW, is it legal/appropriate to specify device (not bus) types for
> > of_platform_bus_probe()?
> 
> In almost all cases you should probe on "name"/"compatible",
> and not use "device_type" at all.

of_platform_bus_probe() is for busses anyway.

Ben.
