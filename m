Return-Path: <afleming@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5C0091007D4
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2011 04:14:58 +1100 (EST)
Subject: Re: [PATCH] phylib: update mdiobus_alloc() to allocate extra private
 space
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Andy Fleming <afleming@freescale.com>
In-Reply-To: <1323967895-5205-1-git-send-email-timur@freescale.com>
Date: Thu, 15 Dec 2011 12:06:01 -0500
Message-ID: <8ABCAC4C-1D11-41AD-AE46-96EB9D40588D@freescale.com>
References: <1323967895-5205-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 15, 2011, at 11:51 AM, Timur Tabi wrote:

> Augment mdiobus_alloc() to take a parameter indicating the number of =
extra
> bytes to allocate for private data.  Almost all callers of =
mdiobus_alloc()
> separately allocate a private data structure.  By allowing =
mdiobus_alloc()
> to allocate extra memory, the two allocations can be merged into one.
>=20
> This patch does not change any of the callers to actually take =
advantage
> of this feature, however.  That change can be made by the individual
> maintainers at their leisure.  For now, all callers ask for zero =
additional
> bytes, which mimics the previous behavior.


Why? Doesn't this just obfuscate things a little, while providing no =
immediate benefit?

Andy=
