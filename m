Message-ID: <001401c07ede$c8187760$4a1f76d8@washington>
From: "Navin Boppuri" <nboppuri@trinetcommunication.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: A working SPI driver in linux
Date: Mon, 15 Jan 2001 10:34:46 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

We have been working on a linux SPI driver for the last few weeks. We have a
basic driver working. We have 3 uarts connected to the SPI working in a
Master-Slave mode. Of course, these is a lot of uart specific code in the
driver. But I do have a skeleton driver specific to the SPI which one can
use for his applications. The driver works only with the microcode patch to
care of the parameter ram problems.

The driver is based on the IIC driver by Dan Malek. Also, a customized SPI
working module (not the driver) was given to me by Tobias Otto-Adamzak.

The driver supports basic open,read,write and close operations. I will have
the commented version ready in a day. If anyone is interested, they can send
me a mail.

Sincerely,
Navin Boppuri.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
