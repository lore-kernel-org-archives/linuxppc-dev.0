Subject: Re: linuxppc-2.5 (mvista rsync) -- drivers/ide/ppc/pmac.c:1843:
	error: request for member `queue_head' in something not a structure or union
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308100851.04174.miles.lane@comcast.net>
References: <200308100851.04174.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1060547919.599.34.camel@gaston>
Mime-Version: 1.0
Date: 10 Aug 2003 22:38:40 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-10 at 17:51, Miles Lane wrote:
>   CC      drivers/ide/ppc/pmac.o
> drivers/ide/ppc/pmac.c: In function `pmac_ide_build_sglist':
> drivers/ide/ppc/pmac.c:1198: warning: passing arg 1 of `blk_rq_map_sg' from
> incompatible pointer type
> drivers/ide/ppc/pmac.c: In function `pmac_ide_dma_test_irq':
> drivers/ide/ppc/pmac.c:1673: warning: comparison is always false due to
> limited range of data type
> drivers/ide/ppc/pmac.c: In function `idepmac_wake_device':
> drivers/ide/ppc/pmac.c:1843: error: request for member `queue_head' in
> something not a structure or union
> drivers/ide/ppc/pmac.c: In function `idepmac_wake_drive':
> drivers/ide/ppc/pmac.c:1927: error: request for member `queue_head' in
> something not a structure or union

I sent an updated version of this driver to linus today

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
