Message-ID: <398EE632.D9A867E@vas-gmbh.de>
Date: Mon, 07 Aug 2000 18:39:14 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: I2C,SPI and QMC
References: <819E3E914E0AD11194DE00805F0D100B0138B86C@fbi.infocom.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I plan to use QMC on SCC1 plus SPI on a MPC855T / 860DT for an ISDN BRI
implementation. I also need I2C for other purposes.
Following the QMCSUPPLEMENT/AD manual from Motorola I found that one looses
either I2C using SCC1 for QMC/Ethernet or SPI using SCC2 for QMC/Ethernet.
I hoped that the I2C/SPI micro code patch would do the trick. But scanning this
mailing list archive I got aware of troubles with this, or even worse that the
patch has been removed from the kernel.
So my question goes like this:
 has anybody managed to use I2C, SPI and QMC on SCC1 altogether, or am I lost
without any hope?

TIA
      Frank

===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
