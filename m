Return-Path: <John.Linn@xilinx.com>
Received: from mail185-va3-R.bigfish.com (mail-va3.bigfish.com
	[216.32.180.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 11F43B7D1A
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:27:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 2/2] net: ll_temac: fix checksum offload logic
Date: Thu, 27 May 2010 07:26:00 -0600
In-Reply-To: <20100526.204517.35032653.davem@davemloft.net>
References: <1274894959-27473-1-git-send-email-john.linn@xilinx.com><0690e798-1e5e-4416-90dc-04a9df16600f@SG2EHSMHS005.ehs.local>
	<20100526.204517.35032653.davem@davemloft.net>
From: John Linn <John.Linn@xilinx.com>
To: "David Miller" <davem@davemloft.net>
Message-ID: <4d2d980b-53f6-457a-b4ef-b1bf82f95138@VA3EHSMHS017.ehs.local>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, michal.simek@petalogix.com,
	Brian Hill <bhill@xilinx.com>, john.williams@petalogix.com
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
> Sent: Wednesday, May 26, 2010 9:45 PM
> To: John Linn
> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
grant.likely@secretlab.ca;
> jwboyer@linux.vnet.ibm.com; john.williams@petalogix.com;
michal.simek@petalogix.com; Brian Hill
> Subject: Re: [PATCH 2/2] net: ll_temac: fix checksum offload logic
> =

> aFrom: John Linn <john.linn@xilinx.com>
> Date: Wed, 26 May 2010 11:29:19 -0600
> =

> > The current checksum offload code does not work and this corrects
> > that functionality. It also updates the interrupt coallescing
> > initialization so than there are fewer interrupts and performance
> > is increased.
> >
> > Signed-off-by: Brian Hill <brian.hill@xilinx.com>
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> =

> Applied, although I changed "temac_features" to be explicitly
> "unsigned int" instead of just plain "unsigned"

Awesome! Appreciate the help with both patches David.

> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
