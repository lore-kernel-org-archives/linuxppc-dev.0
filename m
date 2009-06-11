Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E0361B7197
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:38:10 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D000DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:38:09 +1000 (EST)
Message-Id: <8BE7FB34-A682-4E6D-B3AC-45D5594812C8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090603.035132.157926180.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 4/4] MPC85xx: Add UCC6 and UCC8 nodes in SGMII mode for
	MPC8569MDS
Date: Wed, 10 Jun 2009 20:35:59 -0500
References: <1243951456-4685-2-git-send-email-Haiying.Wang@freescale.com>
	<1243951456-4685-3-git-send-email-Haiying.Wang@freescale.com>
	<1243951456-4685-4-git-send-email-Haiying.Wang@freescale.com>
	<20090603.035132.157926180.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Haiying.Wang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 3, 2009, at 5:51 AM, David Miller wrote:

> From: Haiying Wang <Haiying.Wang@freescale.com>
> Date: Tue,  2 Jun 2009 10:04:16 -0400
>
>> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
>
> I couldn't apply this to net-next-2.6 because this DTS
> file being patched doesn't exist there.
>
> Perhaps the powerpc-next tree can suck it in...

I'll pick this one up and send it via the powerpc tree.

- k
