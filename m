Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF34167BEA
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 17:56:56 +1100 (EST)
Subject: Re: [patch] powerpc: add scanning of ebc bus to of_platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17788.49546.390921.608302@cargo.ozlabs.ibm.com>
References: <20061208114113.2191e446@localhost>
	<1165618381.1103.89.camel@localhost.localdomain>
	<F6853CAA-5CBD-4BA8-A330-55D66AB3E853@kernel.crashing.org>
	<200612091236.57252.arnd@arndb.de>
	<17788.49546.390921.608302@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 17:56:08 +1100
Message-Id: <1165820168.7260.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-12-11 at 13:25 +1100, Paul Mackerras wrote:
> Arnd Bergmann writes:
> 
> > But the platform doesn't need how to drive them, the device driver
> > needs to. All the platform needs to know is the fact that it can
> > deal with SOC devices that are automatically probed.
> > 
> > I'd much prefer to have the list in the same file that drives the
> > devices in the first place. It's probably also good to register
> > them as MODULE_DEVICE_TABLE(), for documentation purposes, even
> > if the driver can't be built as a module yet.
> 
> So is that an ack or a nack for the patch?  Sounds like a nack to me,
> but I'm not sure. :)

Put it in for now.

Ben.
