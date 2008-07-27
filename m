Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F0834DDF09
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 09:14:34 +1000 (EST)
Date: Sun, 27 Jul 2008 16:14:32 -0700 (PDT)
Message-Id: <20080727.161432.237385384.davem@davemloft.net>
To: rdreier@cisco.com
Subject: Re: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
From: David Miller <davem@davemloft.net>
In-Reply-To: <adamyk35aoi.fsf@cisco.com>
References: <20080727182709.1dac0556@lxorguk.ukuu.org.uk>
	<20080727.125604.73857337.davem@davemloft.net>
	<adamyk35aoi.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 27 Jul 2008 13:33:49 -0700

>  > IMHO, this driver was really rushed in and that was a huge mistake.
>  > If it had gone through linux-next we could have tidied all of this
>  > stuff up in a less "rushed" manner.
> 
> ??  This thread *is* about a build failure in linux-next.

The driver went directly into Linus's tree.

Stephen hit the build problem once he synced linux-next up with
Linus's current tree.
