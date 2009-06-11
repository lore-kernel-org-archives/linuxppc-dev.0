Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B9924B7154
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:53:16 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1285EDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:53:15 +1000 (EST)
Message-Id: <F69422EE-2679-43C1-B237-2250B12CFDC4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1243951456-4685-4-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 4/4] MPC85xx: Add UCC6 and UCC8 nodes in SGMII mode for
	MPC8569MDS
Date: Wed, 10 Jun 2009 20:51:04 -0500
References: <1243951456-4685-1-git-send-email-Haiying.Wang@freescale.com>
	<1243951456-4685-2-git-send-email-Haiying.Wang@freescale.com>
	<1243951456-4685-3-git-send-email-Haiying.Wang@freescale.com>
	<1243951456-4685-4-git-send-email-Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, davem@davemloft.net, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 2, 2009, at 9:04 AM, Haiying Wang wrote:

> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |   63 +++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 63 insertions(+), 0 deletions(-)


applied to next.

- k
