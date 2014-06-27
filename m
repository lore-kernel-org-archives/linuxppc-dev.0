Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id B7CEC1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jun 2014 09:14:37 +1000 (EST)
Date: Fri, 27 Jun 2014 16:14:34 -0700 (PDT)
Message-Id: <20140627.161434.502036633250565046.davem@davemloft.net>
To: kda@linux-powerpc.org
Subject: Re: [PATCH v2 1/2] powerpc: bpf: Use correct mask while accessing
 the VLAN tag
From: David Miller <davem@davemloft.net>
In-Reply-To: <1403717697-3911-1-git-send-email-kda@linux-powerpc.org>
References: <1403717697-3911-1-git-send-email-kda@linux-powerpc.org>
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
Date: Wed, 25 Jun 2014 21:34:56 +0400

> To get a full tag (and not just a VID) we should access the TCI
> except the VLAN_TAG_PRESENT field (which means that 802.1q header
> is present). Also ensure that the VLAN_TAG_PRESENT stay on its place
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Applied.
