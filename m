Date: Tue, 5 Dec 2000 14:30:25 +0100 (MET)
From: Tobias Otto-Adamczak <tobias.otto-adamczak@e-technik.tu-chemnitz.de>
To: <tachyon@postech.ac.kr>
cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [i2c] Do I need ucode relocation patch?
Message-ID: <Pine.LNX.4.30.0012051428290.25853-100000@pandora.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > I'm using SCC1 as ethernet and SMC1 as ttyS0.
> > Do I need ucode relocation patch to work with i2c bus?
>
> Yes. This is because the size of the parameter area for SCC1 ethernet is
> bigger than the area allocated it, so they overlap the usual I2C
> parameter area. (There is a similar conflict between SCC2 ethernet and
> SPI.)

There is a pdf document from Motorola with some helpful notes about that
topic:

http://www.mot.com/SPS/ADC/pps/download/8XX/i2c_spi.pdf

Ciao - Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
