Subject: MPC10x I2C driver update
From: Adrian Cox <adrian@humboldt.co.uk>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Cc: lm78@Stimpy.netroedge.com
Content-Type: text/plain
Date: 30 Sep 2003 10:43:55 +0100
Message-Id: <1064915037.12438.1142.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have released a small update to my driver for the
MPC107/MPC8240/MPC8245 I2C adapter. This corrects a bug reported by
several people: the transfer function now follows the other I2C
algorithm drivers by returning the number of elements transferred.

http://www.humboldt.co.uk/mpc10xi2c.html

I'd like to get this into the kernel. Which would be more useful to
people:
1) Getting it into lm-sensors?
2) Getting it into linuxppc-2.4-devel?

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
