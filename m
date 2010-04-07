Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) by ozlabs.org (Postfix) with ESMTP id E9776B7CF0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 23:26:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
Date: Wed, 7 Apr 2010 07:25:37 -0600
In-Reply-To: <20100406.195204.165441511.davem@davemloft.net>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local><1270502993.9013.36.camel@edumazet-laptop>
	<20100406.195204.165441511.davem@davemloft.net>
From: John Linn <John.Linn@xilinx.com>
To: "David Miller" <davem@davemloft.net>, <eric.dumazet@gmail.com>
Message-ID: <b8be47d5-5db7-4e72-a45f-94fc54b7f370@VA3EHSMHS036.ehs.local>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jtyner@cs.ucr.edu,
	michal.simek@petalogix.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Tuesday, April 06, 2010 8:52 PM
> To: eric.dumazet@gmail.com
> Cc: John Linn; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
grant.likely@secretlab.ca;
> jwboyer@linux.vnet.ibm.com; john.williams@petalogix.com;
michal.simek@petalogix.com; jtyner@cs.ucr.edu
> Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
> =

> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Mon, 05 Apr 2010 23:29:53 +0200
> 
> > So, I ask, cant you use netdev_alloc_skb_ip_align() in this driver ?
> 
> Thanks to everyone for getting this patch into shape.
> =

> I applied version 4 of the patch to net-next-2.6, thanks!

Thanks David, appreciate everyone's help and patience.

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
