Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B857@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with CPM I2C driver
Date: Fri, 12 May 2000 11:01:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

After solving my hardware problem on custom MPC823E board and I got my LCD
running, thank you for the help.
But I have a new problem: I want to use the I2C bus, but the driver doesn't
seam to work.

I added CPM IIC and IIC/SPI Microcode patch in xconfig. Then I added the
cpm_iic_init function in drivers/char/mem.c so that is would be called at
startup.

When I try to read some data from /dev/i2c0 the driver just hang. I have
added some printk in the iic driver read function, and it seam to hang just
after enabling the i2c controller.
Can anyone help me with this?

The "driver" in arch/ppc/mbxboot seam to work fine on my board.

Is there any other more complete i2c driver available?

---
Kim Jorgensen

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
