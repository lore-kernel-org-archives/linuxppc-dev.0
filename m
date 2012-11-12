Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 005A82C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2012 08:35:32 +1100 (EST)
Date: Mon, 12 Nov 2012 16:27:23 -0500 (EST)
Message-Id: <20121112.162723.264622334265396904.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
From: David Miller <davem@davemloft.net>
In-Reply-To: <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net>
 <CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com>
 <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, lethal@linux-sh.org,
 paulus@samba.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, hartleys@visionengravers.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Nov 2012 08:26:15 +1100

> Make if easier for more architectures to select it and thus disable
> drivers that use virt_to_bus().
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>
