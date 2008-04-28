Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id CFFD5DE143
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 02:26:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] [MTD] Add support for RAM & ROMmappings in the
	physmap_of MTD driver.
Date: Mon, 28 Apr 2008 11:26:15 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04512785@ismail.innsys.innovsys.com>
In-Reply-To: <200804251353.13698.laurentp@cse-semaphore.com>
References: <200803261344.03438.laurentp@cse-semaphore.com><1208895496.9212.671.camel@pmac.infradead.org><480F19B9.1070403@ru.mvista.com>
	<200804251353.13698.laurentp@cse-semaphore.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>,
	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> Last thing I heard was that the device tree should not encode
> a device's
> expected usage, so memory nodes should not have any
> compatible property that
> would automatically associated them to an MTD driver. I've
> been adviced to
> add platform-specific code to instantiate a platform device manually
> (possibly checking if the required memory node is present in
> the device
> tree). This arguably makes sense, but adds more
> platform-specific code.

So... What good it the device tree at all then, if intended usage should
not be encoded in there.
Most other devices has an intended usage encoded.

Examples would be the FCC's on a Freescale PQ2 chip, where they are
encoded as ethernet controllers. (Thsy could be used as high-speed HDLC
controllers, ATM controllers and other usages), the SCC ports (as
serial, they can be used for syncronous serial and HDLC)

That would also mean if usage would change, the kernel image (and
possiby u-boot) whould have to change, instead of just fixing the device
tree. Argh....
