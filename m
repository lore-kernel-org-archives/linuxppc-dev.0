Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B427AB70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 00:10:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D42ADDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 00:10:25 +1000 (EST)
Message-Id: <70F1C213-8E4B-416D-9414-0D46710FAE32@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1246454380.3681.1634.camel@macbook.infradead.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] Support DMA-API debugging facility on PowerPC
Date: Thu, 2 Jul 2009 09:09:41 -0500
References: <1227284770-19215-1-git-send-email-joerg.roedel@amd.com>
	<1227286492.4901.208.camel@macbook.infradead.org>
	<20081121165722.GD1386@amd.com>
	<1227287215.4901.213.camel@macbook.infradead.org>
	<20081121171802.GK733@elte.hu> <20081121172046.GF1386@amd.com>
	<1227288269.4901.222.camel@macbook.infradead.org>
	<20081121172722.GG1386@amd.com>
	<1233873842.8135.6.camel@macbook.infradead.org>
	<1246454380.3681.1634.camel@macbook.infradead.org>
Cc: Joerg Roedel <joerg.roedel@amd.com>,
	Linux-Kernel List <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	iommu@lists.linux-foundation.org,
	Netdev <netdev@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 1, 2009, at 8:19 AM, David Woodhouse wrote:

>
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> Tested-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> Some fixing from Johannes to make it apply to a current kernel...
>
> arch/powerpc/Kconfig                   |    1
> arch/powerpc/include/asm/dma-mapping.h |   47 +++++++++++++++++++++++ 
> +++++++---
> arch/powerpc/kernel/dma.c              |   11 +++++++
> 3 files changed, 55 insertions(+), 4 deletions(-)

How about CC'ng linuxppc-dev ;)

I'm not sure if Ben will take this for .31 at this point (with Linus's  
post -rc merge constraints) and if so we will probably move to <asm- 
generic/dma-mapping-common.h> for .32

- k
