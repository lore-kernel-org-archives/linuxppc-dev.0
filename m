Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id 4F51067A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 00:16:34 +1100 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 28 Feb 2005 14:15:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200502281415.00431.Schramel.Linux@go.bartec.de>
Subject: isp1362
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

to realize a usb-host on 8270 we use the isp1362 and the working device driver of the denx kernel.
A little code and the 82xx can talk with the usb host.

The boot messages are

...
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
isp1362-HC Detected
usb.c: new USB bus registered, assigned bus number 1
Product: USB OHCI Root Hub
SerialNumber: c7f4b000
hub.c: USB hub found
hub.c: 2 ports detected
isp1362-HC Initialization Successful
...

It seems it is initialized well.

But if i connect a device on the usb bus it is not able to address the usb device.
It outputs :

hub.c: new USB device L-1, assigned address 2
usb_control/bulk_msg: timeout
unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: new USB device L-1, assigned address 3
usb_control/bulk_msg: timeout
unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-110)

Maybe interrupt handling ??

Any ideas ?? All hints are welcome.

Thanks in advance
Marco


---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112
