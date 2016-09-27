Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sjtJf11JqzDrSr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 17:49:22 +1000 (AEST)
Date: Tue, 27 Sep 2016 03:49:18 -0400 (EDT)
Message-Id: <20160927.034918.1429109762920005486.davem@davemloft.net>
To: naveen.n.rao@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, mpe@ellerman.id.au, ast@fb.com,
 daniel@iogearbox.net, ananth@in.ibm.com
Subject: Re: [PATCH 2/2] bpf samples: update tracex5 sample to use
 __seccomp_filter
From: David Miller <davem@davemloft.net>
In-Reply-To: <8e5ab9853508240e901260b1af36243c4d744083.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
References: <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
 <7b29fba6073924dc4c9e7d639eefb0b15a98660d.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
 <8e5ab9853508240e901260b1af36243c4d744083.1474661952.git.naveen.n.rao@linux.vnet.ibm.com>
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
Date: Sat, 24 Sep 2016 02:10:05 +0530

> seccomp_phase1() does not exist anymore. Instead, update sample to use
> __seccomp_filter(). While at it, set max locked memory to unlimited.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Also applied to net-next, thanks.
