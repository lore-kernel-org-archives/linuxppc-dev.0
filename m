Message-Id: <sc8e18c0.080@gw_tms_syd2.pty.tms.thomson-csf.com>
Date: Tue, 12 Mar 2002 15:03:17 +1100
From: "Jeremy Rosen" <Jeremy.Rosen@au.thalesgroup.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: SPI driver for m8xx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everybody

a quick question while the subject of SPI driver is in the air

I am trying to reimplement the driver for the SPI based on the driver
from David Boppuri and Prashant Patel,
and their is a thing I don't understand...

for the TX and RX buffer, they use memory they get for
m8xx_cpm_hostalloc... why ?
Does it have something to do with the MMU ?
I would like to avoid doing that, is their a way to use normal ( kernel
space) memory ?

Thanks

Jeremy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
