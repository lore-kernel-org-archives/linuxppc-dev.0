Message-ID: <903E17B6FF22A24C96B4E28C2C0214D7012BB2A6@sr-bng-exc01.int.tsbu.net>
From: "Karoliya, Abhishek" <Abhishek.Karoliya@fci.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel parameters , getty & serial baud rate
Date: Sun, 5 Oct 2003 17:57:40 +0530 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

     I am using 2.4 Linux on a PPC 7447 based board which uses a terminal
through the serial port.
In my firmware , I can change the baudrate for serial port and this new
baudrate is than communicated to Linux using kernel parameters. But in the
inittab , when getty is run on the serial port it needs the value for
baudrate which is given along with it or in the configuration file of getty.

T0:23:respawn:/sbin/getty -L ttyS0 9600 vt100
T1:23:respawn:/sbin/getty -L ttyS1 9600 vt100

 The board uses a compressed ramdisk image from where it extracts its root
file system.
My problem is how can I configure the inittab to use the value passed down
from the firmware through kernel parameters instead of a hardcode value.

Thanks a million
Abhishek

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
