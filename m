Subject: MPC107 I2C driver
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Cc: sensors@stimpy.netroedge.com
Content-Type: text/plain
Date: 04 Feb 2003 11:49:26 +0000
Message-Id: <1044359381.19358.44.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The first version of my driver for the I2C unit in Motorola's MPC107
bridge chip, plus the 824x integrated processors, is released:

http://www.humboldt.co.uk/mpc10xi2c.html

I'd like to know if it works for other people. I've so far tested it
with a pair of LM75 sensors attached to an MPC107 bridge.

I've used an obvious dummy ID number for the I2C interface: I'd like to
get a real one and move the code into the kernel once I have more
results.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
