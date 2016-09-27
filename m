Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sjtJb0ZC2zDrSr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 17:49:18 +1000 (AEST)
Date: Tue, 27 Sep 2016 03:49:10 -0400 (EDT)
Message-Id: <20160927.034910.2028580268696548096.davem@davemloft.net>
To: naveen.n.rao@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, mpe@ellerman.id.au, ast@fb.com,
 daniel@iogearbox.net, ananth@in.ibm.com
Subject: Re: [PATCH 1/2] bpf samples: fix compiler errors with sockex2 and
 sockex3
From: David Miller <davem@davemloft.net>
In-Reply-To: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
References: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
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
Date: Sat, 24 Sep 2016 02:10:04 +0530

> These samples fail to compile as 'struct flow_keys' conflicts with
> definition in net/flow_dissector.h. Fix the same by renaming the
> structure used in the sample.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to net-next.
