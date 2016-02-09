Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED57B1A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 13:54:12 +1100 (AEDT)
Message-ID: <1454986452.17393.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2 0/4] powerpc/ps3: gelic_udbg: drop local versions of
 network data structs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Luis Henriques <luis.henriques@canonical.com>, Geoff Levand
 <geoff@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Joe Perches <joe@perches.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>,  linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 09 Feb 2016 13:54:12 +1100
In-Reply-To: <1454970427-23017-1-git-send-email-luis.henriques@canonical.com>
References: <1454970427-23017-1-git-send-email-luis.henriques@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-08 at 22:27 +0000, Luis Henriques wrote:

> Several network-related data structures are defined in gelic_udbg.
> These could be easily dropped and the standard ones defined in network
> headers could be used instead.
> 
> The 4 patches that follow replace ethernet, vlan, ip and udp
> structures in gelic_udbg.  Note that this has been compile-tested
> only.
> 
> Changes since v1:
> Include changes suggested by Joe Perches, namely the usage of
> eth_broadcast_addr(), ETH_ALEN, ETH_P_8021Q and ETH_P_IP.
> 
> Luis Henriques (4):
>   powerpc/ps3: gelic_udbg: use struct ethhdr from <linux/if_ether.h>
>   powerpc/ps3: gelic_udbg: use struct vlan_hdr from <linux/if_vlan.h>
>   powerpc/ps3: gelic_udbg: use struct iphdr from <linux/ip.h>
>   powerpc/ps3: gelic_udbg: use struct udphdr from <linux/udp.h>


These look good. But I don't have a setup to test them, does anyone?

I'll merge them and hopefully someone can test them at some point.

cheers
