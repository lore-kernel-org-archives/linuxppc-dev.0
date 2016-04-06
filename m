Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qgGpS5CNTzDq65
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 06:02:08 +1000 (AEST)
Date: Wed, 06 Apr 2016 16:02:06 -0400 (EDT)
Message-Id: <20160406.160206.1261557354384285330.davem@davemloft.net>
To: naveen.n.rao@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net,
 ananth@in.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCHv2 net 2/3] samples/bpf: Use llc in PATH, rather than a
 hardcoded value
From: David Miller <davem@davemloft.net>
In-Reply-To: <000e23c21f475e7106c74a83eb6226c4cb8d4a14.1459789086.git.naveen.n.rao@linux.vnet.ibm.com>
References: <5ab5eec91d2d0bc7f221d714ef84afac83b2604b.1459789086.git.naveen.n.rao@linux.vnet.ibm.com>
 <5ab5eec91d2d0bc7f221d714ef84afac83b2604b.1459789086.git.naveen.n.rao@linux.vnet.ibm.com>
 <000e23c21f475e7106c74a83eb6226c4cb8d4a14.1459789086.git.naveen.n.rao@linux.vnet.ibm.com>
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
Date: Mon,  4 Apr 2016 22:31:33 +0530

> While at it, remove the generation of .s files and fix some typos in the
> related comment.
> 
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied.
