Date: Fri, 1 Feb 2002 13:47:23 -0700
From: Val Henson <val@nmt.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: GT64260 ethernet
Message-ID: <20020201134723.G30787@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We have a board with the Galileo GT64260 chip and we'd like to use the
gt64260 ethernet driver.  At the moment, its config option is in
arch/ppc/config.in and is controlled by the CONFIG_GT64260 option
(which is not turned on for our boards, CONFIG_GEMINI is).  I'd think
that the preferred way to fix this is to put the CONFIG_GT64260_ETH
option in drivers/net/config.in.  The alternative is to have

if [ "$CONFIG_GT64260" = "y" -o "$CONFIG_GEMINI" = "y" ]; then

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
