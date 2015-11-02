Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0200.hostedemail.com
 [216.40.44.200])
 by lists.ozlabs.org (Postfix) with ESMTP id 282791A0368
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 06:57:45 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 7949F11AC10
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 19:51:41 +0000 (UTC)
Message-ID: <1446493892.24485.58.camel@perches.com>
Subject: Re: [net-next v4 1/8] devres: add devm_alloc_percpu()
From: Joe Perches <joe@perches.com>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, scottwood@freescale.com,
 igal.liberman@freescale.com, roy.pledge@freescale.com,
 ppc@mindchasers.com,  pebolle@tiscali.nl, joakim.tjernlund@transmode.se,
 gregkh@linuxfoundation.org
Date: Mon, 02 Nov 2015 11:51:32 -0800
In-Reply-To: <1446485500-9782-2-git-send-email-madalin.bucur@freescale.com>
References: <1446485500-9782-1-git-send-email-madalin.bucur@freescale.com>
 <1446485500-9782-2-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-02 at 19:31 +0200, Madalin Bucur wrote:
> Introduce managed counterparts for alloc_percpu() and free_percpu().
> Add devm_alloc_percpu() and devm_free_percpu() into the managed
> interfaces list.

trivia, could be fixed later

> +/**
> + * __devm_alloc_percpu - Resource-managed alloc_percpu
> + * @dev: Device to allocate per-cpu memory for
> + * @size: Size of per-cpu memory to allocate
> + * @align: Alignement of per-cpu memory to allocate

French spelling?  alignment
