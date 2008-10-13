Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39868DDDEC
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 17:58:43 +1100 (EST)
Message-ID: <48F2F138.6020103@kernel.org>
Date: Mon, 13 Oct 2008 15:56:56 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
In-Reply-To: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>, Wang Jian <lark@linux.net.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> When no irq specified the pata_of_platform fills the irq_res with -1,
> which is wrong to do for two reasons:
> 
> 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
>    is unsigned type, the check will be true for `-1'.
> 
> Reported-by: Steven A. Falco <sfalco@harris.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

applied to #tj-upstream (will soon be sent upstream)

-- 
tejun
