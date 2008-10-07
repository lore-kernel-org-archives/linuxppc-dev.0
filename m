Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D96F6DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 12:47:37 +1100 (EST)
Message-ID: <48EABBD3.1010401@kernel.org>
Date: Tue, 07 Oct 2008 10:30:59 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
In-Reply-To: <20081006213209.GA13072@oksana.dev.rtsoft.ru>
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
> On Mon, Oct 06, 2008 at 03:41:19PM -0500, Matt Sealey wrote:
>> There is a simple problem with the patch which is that an "IRQ 0" can and does
>> actually exist on a bunch of platforms, at least to the best of my knowledge.
>>
>> Checking for -1 (which means for definite, no irq at all, because it is
>> totally unambiguous, as a -1 IRQ numbering is "impossible") is more correct.
> 
> This was discussed years ago.
> 
> http://lkml.org/lkml/2005/11/22/159
> http://lkml.org/lkml/2005/11/22/227
> 

Would this break any existing platforms?  If so, can those be fixed
together or does it become a much bigger problem that way?

Thanks.

-- 
tejun
