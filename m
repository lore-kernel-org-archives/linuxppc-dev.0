Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id E1CC5DDDD4
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 06:25:11 +1100 (EST)
Message-ID: <492AFB92.8090100@harris.com>
Date: Mon, 24 Nov 2008 14:08:02 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: How to partition a PCI device within OF?
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have an FPGA that will be on the PCI bus of a PPC440 processor.
The FPGA unfortunately can only have one "PCI function" (thus one
vendor/device code).  The unfortunate part is that the FPGA has
several logical functions, that should have separate drivers.

Is there a way that I can break out the single PCI device into
several different sub-functions, with separate "sub-function
drivers" using the OF infrastructure?

What I'd like to do is pci_register_driver() once for the whole
device, and when probed by the PCI subsystem, create several OF
viewable sub-devices.  Then, I could have separate OF drivers bind
to the newly created OF sub-devices.

If there are any examples of this, I'd appreciate a pointer.  Or
if I'm completely wedged, and there is a better way to handle the
situation, please say so.

	Steve
