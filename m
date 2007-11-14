Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EA704DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 23:00:14 +1100 (EST)
Message-ID: <473AE325.8070901@scram.de>
Date: Wed, 14 Nov 2007 12:59:33 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] powerpc: Fix fs_enet module build
References: <4739EDA8.6020800@scram.de>
	<20071113.210926.97725854.davem@davemloft.net>
In-Reply-To: <20071113.210926.97725854.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi David,

> This is truly ugly and creates an unnecessarily hard to
> maintain and complex driver.
> 
> Please find a way to fix this for real, so that the
> PPC_CPM_NEW_BINDING ifdef is not necessary at all and
> things get built modular or not naturally as we handle
> things for other cases like this.

I know it's ugly, however, module building is completely
broken right now and I just want to provide a quick and
ugly fix until both that ppc->powerpc transition and the
new binding transition are over. Noone wants to touch the
old stuff any more as it's a pita and it's already scheduled
for removal in a couple of months.

Thanks,
Jochen
