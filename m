Message-ID: <407F8312.3070702@euronet.nl>
Date: Fri, 16 Apr 2004 08:54:10 +0200
From: Jos Beck <jos_beck@euronet.nl>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: FCC Ethernet MDIO interface
References: <4ABDB84E30B89F4E9C942C186F0B9EF605BBC6@4rf-nz-mail.local.4rf.com> <407DEC4A.3080305@embeddededge.com>
In-Reply-To: <407DEC4A.3080305@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Dan,

We are trying to use U-boot for a new MPC8250 circuit.
When looking at cpu/mpc8260/ether_fcc.c I cannot find any reference to
the control of the MDC and MDIO lines of the MII interface to the PHY.

Where can I find the code that controls MDIO? (e.g. to defive which CPM
pins are used)
Is the MDIO interface used/supported anyhow in u-boot or the kernel?


Best Regards,

Jos Beck


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
