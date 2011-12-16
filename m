Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 878711007D4
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2011 07:37:43 +1100 (EST)
Message-ID: <4EEBAC0C.4020104@freescale.com>
Date: Fri, 16 Dec 2011 14:37:32 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] phylib: update mdiobus_alloc() to allocate extra private
 space
References: <1323967895-5205-1-git-send-email-timur@freescale.com>
 <8ABCAC4C-1D11-41AD-AE46-96EB9D40588D@freescale.com>
 <4EEA2A61.8050302@freescale.com>
 <20111216.153254.1998330487051662169.davem@davemloft.net>
In-Reply-To: <20111216.153254.1998330487051662169.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: netdev@vger.kernel.org, afleming@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Miller wrote:
> Make the change how I suggested, where mdiobus_alloc() retains it's current
> function signature and semantics.  Then you can edit drivers as needed rather
> than from the beginning.

Yes, your approach makes much more sense.  I should have thought of it.

-- 
Timur Tabi
Linux kernel developer at Freescale
