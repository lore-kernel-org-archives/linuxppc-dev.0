Subject: MPC107 I2C driver, interrupt driven
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Cc: sensors@stimpy.netroedge.com
Content-Type: text/plain
Date: 25 Mar 2003 17:54:04 +0000
Message-Id: <1048614855.20101.405.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The second version of my driver for the I2C unit in Motorola's MPC107
bridge chip, plus the 824x integrated processors, is now available:

http://www.humboldt.co.uk/mpc10xi2c.html

The changes in this release are:
*) Now interrupt driven.
*) Faster startup.
*) Fixed bug in the stop condition (thanks to Timo Rossi).
*) Uses official adapter and algorithm numbers.

Once more, I welcome feedback on how it works for other people.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
