Message-ID: <003101c315a8$4766e300$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Eitan Rabin" <rabin@mellanox.co.il>,
	"Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <506C3D7B14CDD411A52C00025558DED6030191E8-100000@mtlex01.yok.mtl.com>
Subject: Re: MPC860 and I2C
Date: Thu, 8 May 2003 23:24:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The version of CPU I has requires the patch to solve the conflict  between
> the ram parameters of I2C/SPI and those of Ethernet. I checked my version
> against the errata at Motorola's website and it is required.
>
> If I don't use the relocation then the command has not effect. If I use the
> patch then there are i2c transaction being generated but I can only use
> certain addresses.
>
> Any advice will be appreciated.

What CPU revison do you have? Older CPUs than D4 has a lot of I2C bugs.
If you have an older CPU, try enabling the chip errata code in the i2c driver.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
