Date: Thu, 12 Jun 2003 13:35:44 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: smc91111 on redwood-5?
Message-ID: <20030612113544.GA25541@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am trying to cross-compile a recent 2.5 kernel to redwood-5 (ppc 4xx).
My reference board apparently has an SMC91111 chip on-board, and the
kernel contains a driver for it, but it's not visible in make
menuconfig.

Is this driver working for anyone?  I don't see any Kconfig integration
for it.

Felix

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
