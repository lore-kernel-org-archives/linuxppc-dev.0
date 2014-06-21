Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id BCC281A000D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 13:15:26 +1000 (EST)
Date: Fri, 20 Jun 2014 20:15:18 -0700 (PDT)
Message-Id: <20140620.201518.1196950974891230433.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH 2/2] powerpc/8xx: Remove empty asm/mpc8xx.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <1403312527-4453-2-git-send-email-scottwood@freescale.com>
References: <1403312527-4453-1-git-send-email-scottwood@freescale.com>
 <1403312527-4453-2-git-send-email-scottwood@freescale.com>
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

From: Scott Wood <scottwood@freescale.com>
Date: Fri, 20 Jun 2014 20:02:07 -0500

> m8xx_pcmcia_ops was the only thing in this file (other than a comment
> that describes a usage that doesn't match the file's contents); now
> that m8xx_pcmcia_ops is gone, remove the empty file.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

For networking bits:

Acked-by: David S. Miller <davem@davemloft.net>
