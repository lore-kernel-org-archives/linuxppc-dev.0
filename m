Return-Path: <Haiying.Wang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 112D3DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 00:03:24 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n52E3KUn029217
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jun 2009 07:03:20 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n52E3Jok017942
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Jun 2009 09:03:20 -0500 (CDT)
Subject: Re: [PATCH 1/4] net/phy/marvell: update m88e1111 support for SGMII
	mode
From: Haiying Wang <Haiying.Wang@freescale.com>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090601.025151.146454973.davem@davemloft.net>
References: <12435168302841-git-send-email-Haiying.Wang@freescale.com>
	<20090601.025151.146454973.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 10:03:59 -0400
Message-Id: <1243951440.2927.7.camel@r54964-12.am.freescale.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-06-01 at 02:51 -0700, David Miller wrote:
> Patch 3 of this series doesn't apply cleanly to net-next-2.6
> so I'm dropping the entire patch set.

> Also, in patch 3 you put your signoff in the Subject line.
> 
> Please fix all of this up and resubmit your patch series.

I only verified the first three patches could be applied to your
net-2.6, did not verify whether they could be applied for net-next-2.6.
Sorry.
I've fixed the patch3 against net-next-2.6 now, and will resubmit the
patches.
But the patch4 can not be applied to your net-next-2.6 since there is
not 8569mds support in that tree. Hope Kumar can pick up the patch 4.

Thanks.

Haiying
