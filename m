Subject: LaCie USB HD not working...
From: Bastien Nocera <hadess@hadess.net>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: 18 Jun 2002 21:29:18 +0100
Message-Id: <1024432158.509.8.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm getting another stab at this. I've had this drive for about a year,
never got it to work on my PPC boxes.

Here's the lowdown:
LaCie USB 20G hard-drive, 0x59f/0xa601 ID (it's in the unusual_devs.h)
Some people got it to work it seems:
http://www.qbik.ch/usb/devices/showdev.php?id=68

Here's the log when I plug the device in:
Jun 18 21:04:26 dozo kernel: hub.c: USB new device connect on bus1/1,
assigned device number 2
Jun 18 21:04:26 dozo kernel: usb.c: USB device 2 (vend/prod
0x59f/0xa601) is not claimed by any active driver.
Jun 18 21:04:27 dozo kernel: Initializing USB Mass Storage driver...
Jun 18 21:04:27 dozo kernel: usb.c: registered new driver usb-storage
Jun 18 21:04:30 dozo kernel: usb_control/bulk_msg: timeout
Jun 18 21:04:33 dozo kernel: usb_control/bulk_msg: timeout
Jun 18 21:04:33 dozo kernel: scsi0 : SCSI emulation for USB Mass Storage
devicesJun 18 21:04:44 dozo kernel: usb_control/bulk_msg: timeout

Did anybody got this drive to work on an OHCI controller or even better,
on a PPC ?

Cheers

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
