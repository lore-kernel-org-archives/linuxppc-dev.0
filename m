Date: Tue, 8 Jun 2004 09:01:08 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: eepro100 load
Message-ID: <20040608070108.GO18676@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A (quick) question:

we're using 82551ER silicon with the eepro100 driver to take in data.
After doing some tests where we tried to eliminate all^Wmost other
resource consuming factors, we came to the conclusion that a lot of the
used processing is done in kernel mode handling incoming data, which
seems to contradict the rumoured efficiency of the hardware/driver.

We are currently looking into some settings (rx buffers) in /proc, but
70-80 Mbps with a 350 MHz should be able to handle this without this
much load (seems to be > 60% in kernel mode for the moment for 56 Mbps).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
