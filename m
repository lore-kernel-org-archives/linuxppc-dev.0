Message-ID: <3F33A7CF.1010702@pobox.com>
Date: Fri, 08 Aug 2003 09:38:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Annc: Marvell DB64360 platform support patches available
References: <200308080924.02679.waite@skycomputers.com>
In-Reply-To: <200308080924.02679.waite@skycomputers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brian Waite wrote:
>
> I have finally been able to get a site to post the patches to (with special
> thanks to MontaVista and Dale Farnsworth for the space). Anyone interested
> please let me know of any problems/concerns. Hopefully thes can be
> incorporated soon.
> Patches wer generated from linuxppc_2_4_devel.
>
> ftp://source.mvista.com/pub/mv64360/


Are these patches intended for the kernel?

The ethernet driver, at least, needs a lot of cleaning.  I spotted
several obvious bugs too.

	Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
