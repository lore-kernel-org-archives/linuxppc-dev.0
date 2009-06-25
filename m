Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 80A86B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 17:09:23 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 04402DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 17:09:23 +1000 (EST)
Date: Thu, 25 Jun 2009 11:08:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/2] ucc_geth: Fix half-duplex operation for
	non-MII/RMII interfaces
Message-ID: <20090625070813.GA25653@oksana.dev.rtsoft.ru>
References: <20090625010232.GA28590@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090625010232.GA28590@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 25, 2009 at 05:02:32AM +0400, Anton Vorontsov wrote:
> Currently the half-duplex operation seems to not work reliably for
> RGMII PHY interfaces. It takes about 10 minutes to boot NFS rootfs
> using 10/half link, following symptoms were observed:

David, please ignore these patches, they just appear to
workaround the issue, but they don't fix the root cause (which
is unknown yet), and may cause other side to see the duplex
errors. Heh...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
