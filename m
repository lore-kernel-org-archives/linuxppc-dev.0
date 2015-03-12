Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA7001A0163
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 06:28:18 +1100 (AEDT)
Date: Thu, 12 Mar 2015 15:27:20 -0400 (EDT)
Message-Id: <20150312.152720.2248943963968220981.davem@redhat.com>
To: christophe.leroy@c-s.fr
Subject: Re: [PATCH 7/8] isdn: replace CONFIG_8xx by CONFIG_PPC_8xx
From: David Miller <davem@redhat.com>
In-Reply-To: <20150312152409.E7B5C1A2422@localhost.localdomain>
References: <20150312152409.E7B5C1A2422@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: isdn@linux-pingi.de, linux-serial@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-mtd@lists.infradead.org, user-mode-linux-user@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 12 Mar 2015 16:24:09 +0100 (CET)

> Two config options exist to define powerpc MPC8xx:
> * CONFIG_PPC_8xx
> * CONFIG_8xx
> In addition, CONFIG_PPC_8xx also defines CONFIG_CPM1 as
> communication co-processor
> 
> arch/powerpc/platforms/Kconfig.cputype has contained the following
> comment about CONFIG_8xx item for some years:
> "# this is temp to handle compat with arch=ppc"
> 
> It looks like not many places still have that old CONFIG_8xx used,
> so it is likely to be a good time to get rid of it completely ?
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Acked-by: David S. Miller <davem@davemloft.net>
