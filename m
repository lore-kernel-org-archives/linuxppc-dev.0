Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C6F2FDDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:29:01 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0B5Sv0F021318
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 22:28:57 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0B5Sthw006631
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 23:28:56 -0600 (CST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <e040592354e531e3e9f40059bfc1e0be@kernel.crashing.org>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
	<1168400086.700.12.camel@localhost.localdomain>
	<1168401489.22458.332.camel@localhost.localdomain>
	<1168419440.1704.16.camel@localhost.localdomain>
	<1168431197.22458.336.camel@localhost.localdomain>
	<e040592354e531e3e9f40059bfc1e0be@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1168493395.6411.16.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jan 2007 13:29:56 +0800
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-10 at 20:22, Segher Boessenkool wrote:
> > While I agree that we should definitely test for NULL and properly
> fail
> > instead of crashing, there is still the question of why do you fail
> at
> > this point. Do you have PCI devices that don't have corresponding 
> > device
> > nodes ? That is not a problem per-se, I'm just wondering if you have
> a
> > device that is supposed to have a node but it's not matching due to
> a
> > problem with the "reg" property...
> 
> Yeah, show us the .dts file if you can, it might have
> a problem, or at least it does something the kernel
> doesn't expect.
The dts file just locates at arch/powerpc/boot/dts. MPC8641HPCN and
MPC8548CDS can be treated as example.

I believe the mechanism for PCI bridge description in device tree should
be improved to comply with  OF.
Roy
