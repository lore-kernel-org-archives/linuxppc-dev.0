Return-Path: <vprashant@echelon.com>
Received: from [205.229.50.10] (ntfw.echelon.com [205.229.50.10])
	by ozlabs.org (Postfix) with ESMTP id E95CE67B69
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 04:52:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: USB on MPC8349EMDS
Date: Tue, 2 May 2006 11:52:26 -0700
Message-ID: <DDBD7B17DB2ECE48BCD94C593F7255B401551C7C@monk.echelon.echcorp.com>
From: "Prashant Viswanathan" <vprashant@echelon.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > When I insert a USB Mass storage device (thumb drive), I get the
> > following errors
> >
> > / #  usb 1-2: new high speed USB device using fsl-usb2-mph and
> > address 8
> > usb 1-2: khubd timed out on ep0in
> > usb 1-2: new high speed USB device using fsl-usb2-mph and address 9
> > usb 1-2: khubd timed out on ep0in
> >
> > It does not show up in /proc/bus/usb/devices (I do have usbfs
> > mounted).
> >
> > I also have usb-utils installed and lsusb fails to list the device.
> >
> > I have also tried other USB devices and get similar errors.
> >
> > Has anybody else experience similar problems? Any pointers/help
> > will be
> > appreciated.
>=20
> I know there are some bugs in the Freescale driver that was released
> as part of their BSP.
>=20
> Are you using a PMC2USB module or just the USB ports on the SYS card?
>=20
> - k

I am connecting to the USB port on the board using the USB adaptor. I
tried both configurations (MPH and DR).

I also tried the latest stable kernel (2.6.16.12) but that doesn't
compile for this board. Is there a later (later than 2.16.11) kernel out
there which works for this particular board?

Another possibility might be that the eval board I have is bad. I can't
seem to get my hands on the errata.

Also waiting to hear back from Freescale folks.

Prashant
