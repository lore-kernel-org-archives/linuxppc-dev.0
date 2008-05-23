Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26CE6DE225
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 17:11:07 +1000 (EST)
Message-Id: <F06C1CB1-2A8E-4084-B6EA-7D1D8875E93E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080523162854.2e6ea8f0.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 06/12] net: use linux/of_{device,
	platform}.h instead of asm
Date: Fri, 23 May 2008 02:09:56 -0500
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523162854.2e6ea8f0.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 1:28 AM, Stephen Rothwell wrote:

>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> drivers/net/fs_enet/fs_enet-main.c |    2 +-
> drivers/net/fs_enet/mac-scc.c      |    2 +-
> drivers/net/fs_enet/mii-fec.c      |    2 +-
> drivers/net/ibm_newemac/core.h     |    2 +-
> drivers/net/ucc_geth.c             |    2 +-
> drivers/net/ucc_geth_mii.c         |    2 +-
> 6 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
