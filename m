Message-ID: <8D4C69676E66D511A1CB00508BBBB192011C9F41@ranmx1.ran.harris.com>
From: "Fend, Matthias" <mfend@harris.com>
To: "'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: problems with I2C 
Date: Thu, 13 Jun 2002 05:24:16 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello everybody,

i use a mpc860 with iic,fec and ethernet at SCC3; iic-communication normally
works fine, but sometimes
especially if there is heavy traffic on SCC3 or fec (eg. download of big files)
iic-communication stops with error

... iic-read; short, wanted 32 got 1 ...

also the data seems to be corrupt

it looks like receive buffer descriptor is not the same as before ... ?

has anybody else had these problems or some ideas ?

thx matthias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
