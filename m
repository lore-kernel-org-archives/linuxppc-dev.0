Date: Thu, 28 Feb 2002 13:27:41 +0100 (MET)
From: Gerard Basler <gbasler@ee.ethz.ch>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Bug in drivers/i2c/i2c-algo-ppc405.c ???
Message-ID: <Pine.GSO.4.43.0202281312050.17976-100000@tardis-a01.ee.ethz.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear list,

Does anybody use the i2c driver for ppc405?
These drivers are not part of the standard linux kernel, I found them at
www.netroedge.com/~lm78 (lm_sensors project). (Why?)
I think there's a bug in i2c-algo-ppc405.c
The function iic_xfer (ppc405 implementation of i2c_transfer) returns
always the number of bytes read / written
of the last sub-transaction.
I think it's supposed to return the number of successfully completed
transfers instead.
Just now I can't find something in the documentation on this topic but
I'm sure I've read that somewhere...
(Other drivers like i2c-alg-pcf.c are implemented in this manner)

Perhaps I should better contact the authors... I don't know what the
usual proceeding is concerning such things.

Best Regards,
Gérard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
