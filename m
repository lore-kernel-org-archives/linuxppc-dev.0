Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0CDEF2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 23:23:53 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Centralise CONFIG_ARCH_NO_VIRT_TO_BUS
Date: Wed, 14 Nov 2012 12:23:21 +0000
References: <ADE657CA350FB648AAC2C43247A983F00206B25884B1@AUSP01VMBX24.collaborationhost.net>
 <CAErSpo6WG2R_8sa=rOmAOci-3iFpDs2NFzNkZYxDnD2oTiMQJg@mail.gmail.com>
 <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
In-Reply-To: <20121113082615.2f482eb8835daf46e1f27947@canb.auug.org.au>
MIME-Version: 1.0
Message-Id: <201211141223.21696.arnd@arndb.de>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 H Hartley Sweeten <hartleys@visionengravers.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 12 November 2012, Stephen Rothwell wrote:
>   Show Details
>   Make if easier for more architectures to select it and thus disable
> drivers that use virt_to_bus().
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Very nice, I was recently looking into enabling this for ARM
as well, at least for the platforms that are known to not
need virt_to_bus.

Acked-by: Arnd Bergmann <arnd@arndb.de>
