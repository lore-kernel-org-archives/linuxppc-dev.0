From: "Bradley A. Bosch" <bbosch@iphase.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15955.61193.448312.568754@lachman.com>
Date: Wed, 19 Feb 2003 14:54:33 -0600
To: linuxppc-embedded@lists.linuxppc.org
Cc: bclemens@iphase.com
Subject: MPC107 I2C slave driver code
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

We need to support I2C slave mode on an MPC8241 so we can exchange
messages with another processor asynchronously via I2C.  Adrian's
timely announcement of his new driver was greatly appreciated, but it
doesn't (yet) support slave mode.

Is anyone else working on a driver for slave mode using the I2C
controller in the MPC107, MPC8245 or MPC8241?  If so, we would like to
hear from you and perhaps help, or at least help test your code.

Thanks,

--Brad Bosch
Interphase Corp.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
