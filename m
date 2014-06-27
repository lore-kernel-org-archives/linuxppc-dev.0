Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 8DB4F1A0157
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jun 2014 09:14:42 +1000 (EST)
Date: Fri, 27 Jun 2014 16:14:40 -0700 (PDT)
Message-Id: <20140627.161440.1789637356563737660.davem@davemloft.net>
To: kda@linux-powerpc.org
Subject: Re: [PATCH v2 2/2] powerpc: bpf: Fix the broken
 LD_VLAN_TAG_PRESENT test
From: David Miller <davem@davemloft.net>
In-Reply-To: <1403717697-3911-2-git-send-email-kda@linux-powerpc.org>
References: <1403717697-3911-1-git-send-email-kda@linux-powerpc.org>
 <1403717697-3911-2-git-send-email-kda@linux-powerpc.org>
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
Date: Wed, 25 Jun 2014 21:34:57 +0400

> We have to return the boolean here if the tag presents
> or not, not just ANDing the TCI with the mask which results to:
> 
> [  709.412097] test_bpf: #18 LD_VLAN_TAG_PRESENT
> [  709.412245] ret 4096 != 1
> [  709.412332] ret 4096 != 1
> [  709.412333] FAIL (2 times)
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Applied.
