Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A8B53DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 10:51:13 +1100 (EST)
Date: Wed, 14 Nov 2007 15:51:12 -0800 (PST)
Message-Id: <20071114.155112.34106808.davem@davemloft.net>
To: jochen@scram.de
Subject: Re: [PATCH] powerpc: Fix fs_enet module build
From: David Miller <davem@davemloft.net>
In-Reply-To: <473AE325.8070901@scram.de>
References: <4739EDA8.6020800@scram.de>
	<20071113.210926.97725854.davem@davemloft.net>
	<473AE325.8070901@scram.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Jochen Friedrich <jochen@scram.de>
Date: Wed, 14 Nov 2007 12:59:33 +0100

> I know it's ugly, however, module building is completely
> broken right now and I just want to provide a quick and
> ugly fix until both that ppc->powerpc transition and the
> new binding transition are over. Noone wants to touch the
> old stuff any more as it's a pita and it's already scheduled
> for removal in a couple of months.

Fair enough, I'll apply the patch.

Thanks for the explanation.
