Subject: Re: 2.6.0-test2-bk5 (linus' tree) -- drivers/ide/ppc/pmac.c:1265:
	error: `ide_dma_intr' undeclared (first use in  this function)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308052329.40548.miles.lane@comcast.net>
References: <200308052329.40548.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1060157609.613.45.camel@gaston>
Mime-Version: 1.0
Date: 06 Aug 2003 10:13:29 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-08-06 at 08:29, Miles Lane wrote:
> When these are not set:
> 	CONFIG_BLK_DEV_IDEDMA_PCI
> 	CONFIG_IDEDMA_PCI_AUTO
> 	CONFIG_BLK_DEV_ADMA
> the pmac ide driver won't build.
>
> Perhaps another build constraint is needed?

On my todolist

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
