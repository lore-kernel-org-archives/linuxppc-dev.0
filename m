Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3v2MT62pnjzDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 05:39:06 +1100 (AEDT)
Date: Mon, 16 Jan 2017 13:38:59 -0500 (EST)
Message-Id: <20170116.133859.1157069434816521683.davem@davemloft.net>
To: naveen.n.rao@linux.vnet.ibm.com
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Subject: Re: [PATCH 1/3] powerpc: bpf: remove redundant check for non-null
 image
From: David Miller <davem@davemloft.net>
In-Reply-To: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
References: <e73efe6facf6c06932b4a87707e5978172ee773e.1484326337.git.naveen.n.rao@linux.vnet.ibm.com>
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


I'm assuming these patches will go via the powerpc tree.

If you want them to go into net-next, I kindly ask that you always
explicitly say so, and furthermore always submit a patch series with
a proper "[PATCH 0/N] ..." header posting.

Thanks.
