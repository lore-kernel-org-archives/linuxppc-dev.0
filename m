Message-ID: <CA78D1B723D8D411AF0300508BDCF74F3F6D20@NTCORREO>
From: IGOR LURI <iluri@fagorautomation.es>
To: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: I2c ucode patch
Date: Wed, 8 May 2002 14:12:03 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

We have a custom board based on a mpc 823e (revision B2) with  I2c ,
ethernet (on SCC 3), LCD etc..

Motorola says that concurrent operation of Ethernet and I2C or SPI is not
posible without a ucode patch, but:

- If we don't use I2c ucode patch, we can execute our aplication via nfs,
that reads voltages and temperatures via I2c, so ethernet and I2c work
concurrently.

-	If we use I2c ucode patch, aplication  fails while it tries to write
on I2c device.

Also, we have compared I2c ucode patch downloaded from Motorola and I2c
ucode patch of Denx Linux 2.4.4 kernel source and it seems to be different.

Our cuestion are:

Do we need I2c ucode relocation patch if our aplication works without it?
Why are different Motola and Linux ucode patches?

Thanks in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
