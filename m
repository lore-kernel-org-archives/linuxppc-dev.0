From: Hzzttbb@aol.com
Date: Thu, 25 Oct 2001 19:12:04 EDT
Subject: MPC8260 Interrupt Request
To: <linuxppc-embedded@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <15f.2e06c8f.2909f644@aol.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've connected a SanDisk compact flash to the 8260 local bus and have the interrupt pin wired to ~IRQ1 of the 8260. When I call function 'request_8xxirq' what interrupt number should I be requesting?

The 8260 User's manual says that IRQ1 is interrupt number 19, but if I request that interrupt number it does not work.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
