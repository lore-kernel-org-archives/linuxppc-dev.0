Date: Wed, 24 Jul 2002 13:29:23 -0500
From: Stephen Cameron <scameron@zuul.cca.cpqcorp.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Tigon3 driver, broadcom 5307, 440GP, working?
Message-ID: <20020724132923.A31993@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been playing around with the tigon3 driver and a broadcom
5307 gigabit NIC in my IBM ebony... No luck so far.  The driver compiles
and even loads, I can run ifconfig(busybox really) to configure
the NIC,  and if I pull the network cable, the driver seems to
notice (get log messages about link is down, link is up) but so
far, I can't actually transmit or receive any packets.

Anyone had any luck with this combination?

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
