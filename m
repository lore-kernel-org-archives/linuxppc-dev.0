Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7429DDF77
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:55:48 +1000 (EST)
Message-Id: <C87095E8-991D-4730-8C5A-B132A3157727@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <4864737D.80306@garzik.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 06/12] net: use linux/of_{device,
	platform}.h instead of asm
Date: Wed, 2 Jul 2008 02:55:29 -0500
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
	<20080523162854.2e6ea8f0.sfr@canb.auug.org.au>
	<4864737D.80306@garzik.org>
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


On Jun 26, 2008, at 11:58 PM, Jeff Garzik wrote:

> Stephen Rothwell wrote:
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>> drivers/net/fs_enet/fs_enet-main.c |    2 +-
>> drivers/net/fs_enet/mac-scc.c      |    2 +-
>> drivers/net/fs_enet/mii-fec.c      |    2 +-
>> drivers/net/ibm_newemac/core.h     |    2 +-
>> drivers/net/ucc_geth.c             |    2 +-
>> drivers/net/ucc_geth_mii.c         |    2 +-
>> 6 files changed, 6 insertions(+), 6 deletions(-)
>
> ACK
>
> I'll let a ppc person queue this


I'll pick it up (since it mainly touches fsl enet controllers) if you  
can repost it.  I seem to have lost the patch.

- k
