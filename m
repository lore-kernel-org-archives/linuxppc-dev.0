Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rRSkS2c86zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 15:48:00 +1000 (AEST)
Date: Fri, 10 Jun 2016 22:47:55 -0700 (PDT)
Message-Id: <20160610.224755.1614979708956751311.davem@davemloft.net>
To: naveen.n.rao@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, mpe@ellerman.id.au, matt@ozlabs.org,
 kda@linux-powerpc.org, paulus@samba.org, ast@fb.com, daniel@iogearbox.net,
 ananth@in.ibm.com
Subject: Re: [PATCH 0/6] eBPF JIT for PPC64
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
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

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Tue,  7 Jun 2016 19:02:17 +0530

> Please note that patch [2] is a pre-requisite for this patchset, and is
> not yet upstream.
 ...
> [1] http://thread.gmane.org/gmane.linux.kernel/2188694
> [2] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/96514

Because of #2 I don't think I can take this directly into the networking
tree, right?

Therefore, how would you like this to be merged?
