Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EB0B5B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 18:07:20 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A3641DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 18:07:20 +1000 (EST)
Date: Thu, 25 Jun 2009 01:07:20 -0700 (PDT)
Message-Id: <20090625.010720.07013435.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 1/2] ucc_geth: Fix half-duplex operation for
	non-MII/RMII interfaces
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090625070813.GA25653@oksana.dev.rtsoft.ru>
References: <20090625010232.GA28590@oksana.dev.rtsoft.ru>
	<20090625070813.GA25653@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, afleming@freescale.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 25 Jun 2009 11:08:13 +0400

> On Thu, Jun 25, 2009 at 05:02:32AM +0400, Anton Vorontsov wrote:
>> Currently the half-duplex operation seems to not work reliably for
>> RGMII PHY interfaces. It takes about 10 minutes to boot NFS rootfs
>> using 10/half link, following symptoms were observed:
> 
> David, please ignore these patches, they just appear to
> workaround the issue, but they don't fix the root cause (which
> is unknown yet), and may cause other side to see the duplex
> errors. Heh...

Ok, thanks for the heads-up.
