Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 98E5A1A04EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 07:23:49 +1100 (AEDT)
Date: Thu, 03 Dec 2015 15:23:42 -0500 (EST)
Message-Id: <20151203.152342.830757781812463540.davem@davemloft.net>
To: igal.liberman@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 madalin.bucur@freescale.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se, ppc@mindchasers.com,
 stephen@networkplumber.org
Subject: Re: [v9, 3/6] fsl/fman: Add FMan MAC support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1449127157-9400-4-git-send-email-igal.liberman@freescale.com>
References: <1449127157-9400-1-git-send-email-igal.liberman@freescale.com>
 <1449127157-9400-4-git-send-email-igal.liberman@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: <igal.liberman@freescale.com>
Date: Thu, 3 Dec 2015 09:19:14 +0200

> +static u32 crc_table[256] = {

No way.

We have every conceivable implementation of CRC calculations in the
kernel already.  Use them.
