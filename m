Subject: ibook2 first rev modem
From: Bastien Nocera <hadess@hadess.net>
To: debian-powerpc list <debian-powerpc@lists.debian.org>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: 16 Jan 2002 17:04:04 +0000
Message-Id: <1011200645.6549.23.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've finally been able to get the iBook dual-USB's i2c modem to work and
dialup to my ISP.

The problem lies in the modem's firmware. If you haven't updated the
modem firmware, the modem won't be able to connect at v.90 for some
ISPs. (I verified by dialling up from MacOS X, it didn't work for v90,
but did for v34).

So, to get it to work, reboot under MacOS 9, and run the firmware
updater (that you can find on Apple's Tech Support website).

Cheers

PS: Here is the modem init line I use:
\d\d\d\d\d\d\dAT&FE0W1Q0V1X4&C1&K3S95=1&D3S7=75S0=0+MS=11,1,300,33600

I tried adding an M0 somewhere, but couldn't get the modem to shut up.
Any ideas ?

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
