Return-Path: <almoeli@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4023167B14
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 18:56:08 +1000 (EST)
Message-ID: <447FFD1E.6030208@gmx.de>
Date: Fri, 02 Jun 2006 10:55:58 +0200
From: almoeli@gmx.de
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: USB on MPC8349 with MPH controller
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

im using kernel 2.6.16.18 with the ehci-fsl and a patch from this list
to get USB working.
So SCCR and SICRL register are set correctly.
The external connected PHY is a SMSC 3300-EZK which has an ULPI interface.
If I configure the USB controller of the MPC8349 to use the DR
controller, port 1 can be used with low, full and high speed devices
without any errors.
But if the USB controller is switched to MPH, the port 0 and port 1
cannot read the device descriptor.
Error message is:

fsl-usb2-mph: devpath1 ep0in 3strikes
fsl-usb2-mph: devpath1 ep0in 3strikes
fsl-usb2-mph: devpath1 ep0in 3strikes
usb1-1: device decriptor read/64, error -71

Does anyone know this problem or knows a solution?

Oliver
