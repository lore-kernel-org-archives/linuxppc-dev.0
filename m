To: linuxppc-dev@lists.linuxppc.org
Subject: [ANN] Graphics Drivers for Fujitsu Coral-P available
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Wed, 31 Mar 2004 19:52:56 +0200
Message-Id: <20040331175301.EF2A3C109A@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


DENX has released source code and patches for a preliminary version
of graphics drivers for the Fujitsu "Coral-P" graphics card for
big-endian Linux systems (like PowerPC). The code is available as
Free Software under GPL at ftp://ftp.denx.de/pub/fujitsu/Coral-P/

The code was especially developed for and tested on a Motorola
LITE5200 board featuring the MPC5200 processor, running a standard
Debian installation including KDE etc.

Please see the included README for instructions. A tutorial how to
install Debian on a MPC5200 system is available in the DULG:
http://www.denx.de/twiki/bin/view/DULG/DebianOnPowerpcInstallationHowto

More efficient drivers which will actually utilize the advanced
graphics features of the Coral-P chip are under development. DENX
will make this much more powerful accelerated X11 driver available
soon. Of course it will be Free Software under GPL, too.

[Please drop me a note if you are interested in a ATA  harddisk  with
Debian & the graphics drivers pre-installed.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Security is mostly a superstition. It does not  exist  in  nature...
Life is either a daring adventure or nothing."         - Helen Keller

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
