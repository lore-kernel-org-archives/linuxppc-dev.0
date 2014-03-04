Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 080EE2C035A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 08:48:10 +1100 (EST)
Date: Tue, 04 Mar 2014 16:48:06 -0500 (EST)
Message-Id: <20140304.164806.1723542180554308406.davem@davemloft.net>
To: bhelgaas@google.com
Subject: Re: [PATCH 2/2] sparc64: Remove unused sparc64_multi_core
From: David Miller <davem@davemloft.net>
In-Reply-To: <20140304210744.16893.75929.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140304210744.16893.75929.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Mar 2014 14:07:44 -0700

> Remove sparc64_multi_core because it's not used any more.
> 
> It was added by a2f9f6bbb30e ("Fix {mc,smt}_capable()"), and the last uses
> were removed by e637d96bf462 ("sched: Remove unused mc_capable() and
> smt_capable()").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: David S. Miller <davem@davemloft.net>
