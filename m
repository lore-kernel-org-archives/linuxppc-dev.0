Subject: Re: Pegasos 2 support patch ...
From: Adrian Cox <adrian@humboldt.co.uk>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040629165029.GA13468@pegasos>
References: <20040629165029.GA13468@pegasos>
Content-Type: text/plain
Message-Id: <1088587090.28598.3.camel@localhost>
Mime-Version: 1.0
Date: Wed, 30 Jun 2004 10:18:10 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-06-29 at 17:50, Sven Luther wrote:
> The remaining problem for the pegasos 2 is with the via82cxxx ide
> driver, which needs to support a different irq for both channels, thus
> breakign when a device is present on the second ide channel. The
> pegasos-via82cxxx.diff patches is a hcky soltuion for this, but is
> naturally not fit for mainstream inclusion. I would welcome any hint on
> how to solve this issue.

I have a board which has the same problem.

My current idea is to add an extra flag to the ide_pci_device_t to
indicate that the device defaults to ports 14 and 15, then modify
ide_hwif_configure() to use this flag.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
