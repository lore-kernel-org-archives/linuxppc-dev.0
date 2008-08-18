Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F05F4DE1AA
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 00:35:29 +1000 (EST)
Message-Id: <7993F0B5-401D-46D6-B6BD-29FE56D93905@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20080612003219.12670.66981.stgit@vitb-lp>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] [fs_enet] powerpc: Fix SCC Ethernet on CPM2,
	and crash in fs_enet_rx_napi()
Date: Mon, 18 Aug 2008 09:34:50 -0500
References: <20080612003219.12670.66981.stgit@vitb-lp>
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2008, at 7:32 PM, Vitaly Bordug wrote:

> From: Heiko Schocher <hs@denx.de>
>
> Initially posted on:
> http://ozlabs.org/pipermail/linuxppc-dev/2008-January/049682.html
> Feedback is addressed in this version (yes, this patch was floating  
> around for a while...)
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> ---
>
> drivers/net/fs_enet/fs_enet-main.c |   10 +++++++++-
> drivers/net/fs_enet/mac-scc.c      |    8 +++++++-
> include/asm-powerpc/cpm2.h         |    5 +++++
> 3 files changed, 21 insertions(+), 2 deletions(-)

Jeff, any reason this wasn't picked up ?

- k
