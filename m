Message-ID: <3A75F8A8.64ADB0C@vacuumgenesis.com>
Date: Mon, 29 Jan 2001 15:11:36 -0800
From: Timothy Ritchey <tritchey@vacuumgenesis.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 860T FEC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone had any luck with the 860T FEC driver in the 2.4 kernel (I am
using the 01/13/01 snapshot from FSMLabs). It is certainly not working
out-of-the-box as it were. For example, it tries calling mii_queue with
read operations that require the MII interrupt before interrupts have
even been enabled. There is code that needs to be run in the
fec_restart() function (such as the interrupt enable, and just enabling
the ethernet device) but it is never called. I cannot see how this code
was ever working properly. Is anyone running it that can refute this? I
have made some changes that seem to get it halfway there, but am not
getting any transmit interrupts yet (I am getting receive and mii
interrupts).

Cheers,
tim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
