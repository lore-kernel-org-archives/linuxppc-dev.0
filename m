Return-Path: <John.Linn@xilinx.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D2621B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 19:32:42 +1000 (EST)
Received: from IE1EHSOBE003.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 31124DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 19:32:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] [V2] net: add Xilinx emac lite device driver
Date: Thu, 20 Aug 2009 03:32:32 -0600
In-Reply-To: <20090820.023047.86718643.davem@davemloft.net>
References: <20090819122920.37EE21728051@mail110-dub.bigfish.com><20090820.022536.264747725.davem@davemloft.net><4A8D1750.4000804@petalogix.com>
	<20090820.023047.86718643.davem@davemloft.net>
From: John Linn <John.Linn@xilinx.com>
To: "David Miller" <davem@davemloft.net>,
	<michal.simek@petalogix.com>
Message-ID: <20090820093235.6009BD7804E@mail8-dub.bigfish.com>
Cc: Sadanand Mutyala <sadanan@xilinx.com>, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com, john.williams@petalogix.com
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
> Sent: Thursday, August 20, 2009 10:31 AM
> To: michal.simek@petalogix.com
> Cc: John Linn; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
jgarzik@pobox.com;
> grant.likely@secretlab.ca; jwboyer@linux.vnet.ibm.com;
john.williams@petalogix.com; Sadanand Mutyala
> Subject: Re: [PATCH] [V2] net: add Xilinx emac lite device driver
> =

> From: Michal Simek <michal.simek@petalogix.com>
> Date: Thu, 20 Aug 2009 11:28:48 +0200
> =

> > There were one bug with spinlock which John L fixed but not send to
> > mainling list. :-(
> > He wanted to create new v3 version. :-(.
> > When he wake up, he send you that bug fix or v3 version with it.
> =

> Send a new version, I'll revert V2 from my tree as I didn't push it
> out yet.

I'll send a V3 version very soon, thanks. =


Sorry for the hassle as I thought there would be more comments and I'd
incorporate the bug fix into those.

Appreciate your help.

-- John

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
