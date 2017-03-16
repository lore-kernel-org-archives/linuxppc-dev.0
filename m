Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vkc8t01HrzDqY5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 05:15:40 +1100 (AEDT)
Date: Thu, 16 Mar 2017 11:15:34 -0700 (PDT)
Message-Id: <20170316.111534.1198546983950341144.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Cc: isdn@linux-pingi.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH] isdn: hardware: mISDN: Remove reference to CONFIG_8xx
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170316091802.E463D68481@localhost.localdomain>
References: <20170316091802.E463D68481@localhost.localdomain>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 16 Mar 2017 10:18:02 +0100 (CET)

> CONFIG_8xx is deprecated and should soon be removed in favor
> of CONFIG_PPC_8xx.
> Anyway, hfc_multi_8xx.h only uses 8xx I/O ports which are
> linked to the CPM1 communication processor included in the 8xx
> rather than the 8xx itself.
> 
> This patch therefore makes it dependent on CONFIG_CPM1 instead,
> like several other drivers.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied.
