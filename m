Message-ID: <407FD8EE.306@embeddededge.com>
Date: Fri, 16 Apr 2004 09:00:30 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jos Beck <jos_beck@euronet.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FCC Ethernet MDIO interface
References: <4ABDB84E30B89F4E9C942C186F0B9EF605BBC6@4rf-nz-mail.local.4rf.com> <407DEC4A.3080305@embeddededge.com> <407F8312.3070702@euronet.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


First of all, this should be posted on the u-boot mailing list, not here.

Jos Beck wrote:

> We are trying to use U-boot for a new MPC8250 circuit.

> Where can I find the code that controls MDIO? (e.g. to defive which CPM
> pins are used)

If you take a look at some other 8260 derivative boards, it's kinda
obvious how it is done.  First CONFIG_MII, CONFIG_BITBANGMII.  Define
the macros for MDIO, MDC, and MIIDELAY specific to your implementation.
Due to the wide variation of implementation, the PHY management is done
from the board specific files, not in the generic FCC driver.  Take a
look at board/mpc8260ads/mpc8260ads.c.

> Is the MDIO interface used/supported anyhow in u-boot or the kernel?

Yes, in many different variations that you can model to suit your needs.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
