Message-ID: <B25E2E5A003CD311B61E00902778AF2A0204430F@server1.skystream.com>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405GP ethernet driver
Date: Thu, 25 Jan 2001 17:03:29 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone been using the 405GP ethernet driver from MontaVista?

It looks like it is based on a driver from IBM.  The transmit mechanism is
different from other linux ethernet drivers that I am familiar with.  Looks
like they only use a single TX buffer descriptor.  The TX interrupt must be
serviced before the next packet can be sent, which leads to lower
performance.  Mine tops out around 60Mbps.

Has anyone tinkered with this driver to implement a real TX ring buffer?  I
don't want to duplicate effort if the work is already done.

Thanks,
Brian Kuschak


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
