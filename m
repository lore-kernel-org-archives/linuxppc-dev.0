Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 968591007D2
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Dec 2011 18:41:32 +1100 (EST)
Date: Wed, 07 Dec 2011 02:39:16 -0500 (EST)
Message-Id: <20111207.023916.980093028693181777.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH net-next v6 4/4] powerpc: tqm8548/tqm8xx: add and
 update CAN device nodes
From: David Miller <davem@davemloft.net>
In-Reply-To: <1323243268.660.71.camel@pasglop>
References: <1322732481-2255-1-git-send-email-wg@grandegger.com>
 <1322732481-2255-5-git-send-email-wg@grandegger.com>
 <1323243268.660.71.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-can@vger.kernel.org, linuxppc-dev@ozlabs.org,
 socketcan-users@lists.berlios.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Dec 2011 18:34:28 +1100

> Let me know if I should just remove them from powerpc patchwork.

These are DT entries for CAN devices for which drivers only exist in
the net-next tree, I already included this patch into the net-next
tree so you do not have to.
