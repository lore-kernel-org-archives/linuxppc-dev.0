Message-Id: <sd05c43a.096@mail.frequentis.com>
Date: Tue, 11 Jun 2002 09:34:43 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: 2 Ethernet ports on a MPC860T
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all!

We have to redesign our customer board next year, and there is a requirement to use two ethernet ports. At the moment we use of course the FEC with 10/100 MBit. So we want to add a SCC (SCC3 fits for us ...) for a second ethernet. Is that configuration supported by linux, or easy to adapt? (to switch from another SCC to SCC3 or similar).

What kind of external devices are necessary? And how do you store the MAC Address? (We do it at the moment via a one wire chip, they garant for the right MAC Address).

Thanks in advance

Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
