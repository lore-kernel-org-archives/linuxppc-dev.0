Message-ID: <D73A25AA6E54D511AD74009027B1110F3C07F5@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Stefano Bodini'" <s.bodini@comcast.net>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: SPI again
Date: Fri, 18 Apr 2003 11:46:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Actaully you are using the I2C.  Early in the boot Linux uses the I2C to
read configuration keys from the onboard EEPROM.

-----Original Message-----
From: Stefano Bodini [mailto:s.bodini@comcast.net]
Sent: Friday, April 18, 2003 11:26 AM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: SPI again



Hi

I spent a lot of time searching on the net and in this mailing list about a
problem I'm having with the SPI but so far the information I found didn't
help me too much (I found great suggestions anyway)... I really needs
suggestions.
I'm working on an Embedded Planet Card (CLX), PPC860 with the kernel 2.4.17
from MontaVista (Hard Hat Pro 2.1).

I'm developing a kernel module that include also the SPI, i.e. I have my
code to handle the SPI, I'm not using the device driver for the SPI inside
the kernel.
So I'm using ioremap (I also used ioremap_nocache) to obtain the DPR and
register area for the SPI, I allocate the BDs with the help of the
m8xx_cpm_dpalloc() function (I've not yet applied the patches to allow the
release of the DPR allocated, but at the moment is ok).

Is important to know that the SPI management I'm trying to use under Linux,
is working under other platforms (for example VxWorks, PsOS, MQX, ecc.),
i.e. I'm confident about how to program and use the SPI itself.

All seems ok, all the registers and DPR area contains the expected values.
The problem is that when I fire the SPI I can see only 1 clock coming out
on the SPICLK pin. And no data are sent out to the other SPI pins.

Ah, the Hw is ok. Same hardware with different platform/OS is working fine.

I tried to compile the kernel with and without the RISC patches for the SPI
(beside I'm using SCC1 for ethernet and not using I2C at all) and of course
modifying the SPI driver accordingly.
No way, I continue to see only 1 clock coming out every time I fire the SPI.

So .. anybody has some suggestions about what can be ?

Thanks in advance !!!

C'ya
	Steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
