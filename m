Message-ID: <002501c315a7$7e309260$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Eitan Rabin" <rabin@mellanox.co.il>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <506C3D7B14CDD411A52C00025558DED603018B6A-100000@mtlex01.yok.mtl.com>
Subject: Re: MPC860 and I2C
Date: Thu, 8 May 2003 23:19:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi All,
>
> I'm trying to use the MPC I2C controller to generate I2C transactions. I
> use  the devel kernel version and include the I2C relocation patch (seen
> in /var/log/messages).

Can you post the message it prints?

>
> I used the standard I2C driver and also tried the driver downloaded
> directly from lmsensors.
>
> The problem occurs when I activate the master. As soon as I give the
> master the start command (i2c->i2c_i2com = 0x80) for the DMA transaction
> to start the CPU complete freezes.
> I narrowed the problem and found out the it is actually the address of the
> descriptor the one causing the CPU to hang. If I give addresses that are
> relatively small, few Kilos, then everything is OK. If I give addresses
> that are given to me by kmalloc and translated properly then the cpu
> hangs.

What address? Have you made any changes to the driver?
Can you post some example code?

> It seems to me that maybe something is wrong with the SDMA
> configuration.

hmm, if SDMA doesn't work as it should I think you would experience
problems with the console and ethernet.

Make sure that SDA and clock signals has a pull up resistor.

Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
