Message-ID: <39551A4B.2D488E6@claudio.ch>
Date: Sat, 24 Jun 2000 22:30:03 +0200
From: Claudio Nieder <private@claudio.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel >=2.2.16 on Lombard
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm not able to use either linuxBenh or linuxStable, which I
rsynced some hours ago from linuxcare, on my Lombard. I use
the .config as supplied (just calling make oldconfig before
make dep etc.). My last kernel I built was 2.2.15pre19 from
one of the above sources, and it works well.

linuxBenh, which identifies itself as version 2.2.16, will stop
early during boot with the message:

  pmac nvram is core99: 0
  Don't know how to access NVRAM with 0 addresses.

linuxStable, which identifies itself as version 2.2.17pre3 will stop
even earlier, after the line

  booting...

was printed. If anybody was succesful in using one of the above
kernels on the Lombard I'd appreciate, if you could send me your
.config.

		Thank you
				claudio
--
Claudio Nieder, Kanalweg 1, CH-8610 Uster, Tel +41 79 357 6743
mailto:private@claudio.ch  http://www.claudio.ch  icq:42315212

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
