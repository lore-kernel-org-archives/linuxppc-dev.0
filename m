Date: Wed, 5 Nov 2003 16:51:59 +0100
From: xavier grave <grave@ipno.in2p3.fr>
To: Vincenzo Forchi` <vincenzo.forchi@elettra.trieste.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Irq time response with rtai + linux-2.4.20 kernel with a mvme5500
Message-ID: <20031105155159.GG22947@ipnpcu9.acq.ami>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everybody,

Everything is now running on my mvme5500 board :
linux-2.4.20 + motorolla patches + rtai 2.4.18 patches
our local universe driver with a few modifications
After a setpci in order to have a sufficent pci window for the tundra
windows (Thanks to Ajit Prem) everythings works.

We have setup a test crate with irq at 500 Hz. The irq handler write to
the VME only after 4.3 microseconds. The only bigger value is about 6/7
microseconds due to caching effects.

I will put order in the driver code before putting the sources on the
web (mixed code from 2300/5100 with the one for the 5500 board).

xavier

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
