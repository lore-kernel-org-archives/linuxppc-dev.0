Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8803A67B73
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 14:57:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k644vt3h004596
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Jul 2006 21:57:55 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k644vrEj002590
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Jul 2006 23:57:55 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E05002@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: [PATCH] Add QE device tree definition
Date: Tue, 4 Jul 2006 12:57:52 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +   3) USB (Universal Serial Bus Controller)
> > +
> > +   Required properties:
> > +   - device_type : should be "usb".
> > +   - compatible : could be "qe_udc" or "fhci-hcd".
> > +   - model : the could be "host" or "slave".
> 
> got a 'l' on mode, if we are slave should we provide more info about
> what kinda slave we are (ie, what gadget driver should apply).

In current implementation of gadget, gadget driver is selected in kernel config and module loading.  Different gadget drivers can't be loaded at the same time for now.  Thus, having it in device tree will have no actual use.
> 
> > +   - reg : there will be two tuples of "address size".  The first
> > tuple is
> > +     offset and length of the device registers respectively; the
> > second is
> > +     offset and length of the device parameter RAM respectively.
> > +   - interrupts : <a b> where a is the interrupt number and b is a
> > +     field that represents an encoding of the sense and level
> > +     information for the interrupt.  This should be encoded based on
> > +     the information in section 2) depending on the type of interrupt
> > +     controller you have.
> > +   - interrupt-parent : the phandle for the interrupt controller that
> > +     services interrupts for this device.
