Subject: MPC8560ADS issues
From: Jason McMullan <jason.mcmullan@timesys.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <1078945499.3748.4.camel@veena.timesys>
Mime-Version: 1.0
Date: Wed, 10 Mar 2004 14:04:59 -0500
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to work with FCCs on my PowerQuick III with a
MPC8560 Rev 1, and I'm having quite a difficult time attempting
to get the FCC ethernet ports to work.

The GigE (TSEC) ports work just fine, but the FCC ports don't seem
to TX or RX anything. No IRQs from the FCC, but I get IRQs from the
PHYs

Switch settings:

SW4:  1-4 ON, 5-8 OFF
SW10: 1 ON, 2-6 OFF, 7-8 ON
SW13: 1 OFF, 2-3 ON

J23,J22: MII(std)
J27,J31: MII

  I have also verified that both of the FCC PHY's on the MII bus
are visible (at PHY IDs 2 and 3).

  Has anyone had any success with the MPC8560ADS and FCCs? In either
Linux or u-boot?


--
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
