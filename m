Date: Mon, 7 Oct 2002 15:23:25 -0400
From: Patrick Mahoney <pmahoney@8d.com>
To: linuxppc-embedded@lists.linuxppc.org,
	Brad Parker <brad@heeltoe.com>, Simon Vogl <simon@tk.uni-linz.ac.at>
Subject: i2c on mpc850
Message-ID: <20021007192325.GA7735@segfault.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a custom board (with an atmel microcontroller) over a rpxlite
dw (mpc850) running linux. I want them to talk i2c to each other. I
would like anyone of them to be able to initiate communication.

The MPC850 is multimaster-capable. But i don't believe this feature is
implemented in the linux kernel (i2c-algo-8xx.c). Am I right?

If so, what is the best way of emulating multimaster mode? I thought a
simple way of doing so would be for the custom board cto ause an
interrupt which would trigger a i2c master-read command, therefore
keeping the linux board in master-only mode and the atmel one in
slave-only mode...

Any comment/suggestion?

Best regards,



Patrick Mahoney

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
