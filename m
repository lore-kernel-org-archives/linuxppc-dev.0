In-Reply-To: <20000301010720K.roikawa@rr.iij4u.or.jp>
Date: Tue, 29 Feb 2000 17:45:47 +0100
To: ad@mpifr-bonn.mpg.de
CC: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: FireWire + Apple PB G3: some success
Message-Id: <20000229174547.008164@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 1, 2000, Ryuichi Oikawa <roikawa@rr.iij4u.or.jp> wrote:

>Have you checked if the patch you used is really working correctly?
>It setups CardBus bridge's interrupt routing for only TI1130(0xac12)
>and TI1131(0xac15) (see the patch to arch/ppc/kernel/pmac_pci.c).
>You will have to add support for your CardBus bridge(ID 0xac1e)
>referring the document from TI.

ac1e is the TI-1211. This is the same CardBus chip used in the new Pismo
powerbook. It's datasheet can be found on TI web site with the complete
register set.

BTW. I didn't find register infos in the datasheet for the TI-1131. Do
you have those ? I'd be interested. I found only the pinout and
electrical specs.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
