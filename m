From: laurent.mohin@acterna.com
To: IGOR LURI <iluri@fagorautomation.es>
Cc: EMBEDDED LINUXPPC (=?iso-8859-1?Q?Correo_electr=F3nico?=) <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <C1256BB8.0031050D.00@magnus.eni.wago.de>
Date: Mon, 13 May 2002 10:47:36 +0200
Subject: Re: I2c ucode patch
Mime-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=jH41HNvKelY0T13y7P3BfIU955XD8RopSFvOcc7oKohvtW4C3kHy9kd8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0__=jH41HNvKelY0T13y7P3BfIU955XD8RopSFvOcc7oKohvtW4C3kHy9kd8
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable




Igor,

The need of ucode patch is due to the parameter ram organization into t=
he dual
port ram (as described in table 16.3 of the MPC823e reference manual).
Below the table, you can read a little note saying that the SCC2 sectio=
n will
overlap the SPI section if SCC2 is used for Ethernet and that SCC3 sect=
ion will
overlap SMC1 section if SCC3 is used for Ethernet.
In your case, you don't need a ucode patch to make I2C working.

Laurent




IGOR LURI <iluri@fagorautomation.es> on 08/05/2002 14:12:03

To:   EMBEDDED LINUXPPC (Correo electr=F3nico)
      <linuxppc-embedded@lists.linuxppc.org>
cc:
Subject:  I2c ucode patch


=

--0__=jH41HNvKelY0T13y7P3BfIU955XD8RopSFvOcc7oKohvtW4C3kHy9kd8
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



Hi all,

We have a custom board based on a mpc 823e (revision B2) with  I2c ,
ethernet (on SCC 3), LCD etc..

Motorola says that concurrent operation of Ethernet and I2C or SPI is not
posible without a ucode patch, but:

- If we don't use I2c ucode patch, we can execute our aplication via nfs,
that reads voltages and temperatures via I2c, so ethernet and I2c work
concurrently.

-    If we use I2c ucode patch, aplication  fails while it tries to write
on I2c device.

Also, we have compared I2c ucode patch downloaded from Motorola and I2c
ucode patch of Denx Linux 2.4.4 kernel source and it seems to be different.

Our cuestion are:

Do we need I2c ucode relocation patch if our aplication works without it?
Why are different Motola and Linux ucode patches?

Thanks in advance.





--0__=jH41HNvKelY0T13y7P3BfIU955XD8RopSFvOcc7oKohvtW4C3kHy9kd8--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
