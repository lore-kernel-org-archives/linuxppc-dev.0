Return-Path: <eric.dumazet@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217]) by ozlabs.org (Postfix) with ESMTP id D2219B7D2D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 23:31:31 +1000 (EST)
Received: by bwz9 with SMTP id 9so802190bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Apr 2010 06:31:28 -0700 (PDT)
Subject: RE: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
From: Eric Dumazet <eric.dumazet@gmail.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <b8be47d5-5db7-4e72-a45f-94fc54b7f370@VA3EHSMHS036.ehs.local>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
	<20100406.195204.165441511.davem@davemloft.net>
	<b8be47d5-5db7-4e72-a45f-94fc54b7f370@VA3EHSMHS036.ehs.local>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 15:31:23 +0200
Message-ID: <1270647083.8141.0.camel@edumazet-laptop>
Mime-Version: 1.0
Cc: michal.simek@petalogix.com, netdev@vger.kernel.org, jtyner@cs.ucr.edu,
	linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le mercredi 07 avril 2010 à 07:25 -0600, John Linn a écrit :
> > -----Original Message-----
> > From: David Miller [mailto:davem@davemloft.net]
> > Sent: Tuesday, April 06, 2010 8:52 PM
> > To: eric.dumazet@gmail.com
> > Cc: John Linn; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
> grant.likely@secretlab.ca;
> > jwboyer@linux.vnet.ibm.com; john.williams@petalogix.com;
> michal.simek@petalogix.com; jtyner@cs.ucr.edu
> > Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
> > 
> > From: Eric Dumazet <eric.dumazet@gmail.com>
> > Date: Mon, 05 Apr 2010 23:29:53 +0200
> > 
> > > So, I ask, cant you use netdev_alloc_skb_ip_align() in this driver ?
> > 
> > Thanks to everyone for getting this patch into shape.
> > 
> > I applied version 4 of the patch to net-next-2.6, thanks!
> 
> Thanks David, appreciate everyone's help and patience.
> 

You're welcome ;)

Thanks
