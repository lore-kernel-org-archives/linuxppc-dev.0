Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 4A0DF1A0F53
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 07:56:15 +1100 (AEDT)
Date: Thu, 19 Feb 2015 15:56:13 -0500 (EST)
Message-Id: <20150219.155613.1219259214030608341.davem@davemloft.net>
To: kda@linux-powerpc.org
Subject: Re: bpf: Enable BPF JIT on ppc32
From: David Miller <davem@davemloft.net>
In-Reply-To: <1424156683-2682-1-git-send-email-kda@linux-powerpc.org>
References: <1424156683-2682-1-git-send-email-kda@linux-powerpc.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Tue, 17 Feb 2015 10:04:37 +0300

> This patch series enables BPF JIT on ppc32. There are relatevily
> few chnages in the code to make it work.
> 
> All test_bpf tests passed both on 7447a and P2041-based machines.
> 
> Changelog:
> v1 - > v2: Reordered Kconfig patch in the series

Who plans to take this series?  A PowerPC maintainer?

If not, should I take it?
