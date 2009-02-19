Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8AC8BDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 07:58:52 +1100 (EST)
Message-Id: <41C03C27-3B63-4691-B165-89457EA20908@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/3] powerpc/pci: Default to dma_direct_ops for pci dma_ops
Date: Thu, 19 Feb 2009 14:58:31 -0600
References: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 19, 2009, at 2:49 PM, Kumar Gala wrote:

> This will allow us to remove the ppc32 specific checks in  
> get_dma_ops()
> that defaults to dma_direct_ops if the archdata is NULL.  We really
> should always have archdata set to something going forward.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/kernel/pci-common.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

Ben,

If you can look at putting these in testing that would be great.

I'd like to see of Josh can get some 4xx/44x runs to see if we break  
anything there.  I don't expect it but good to see.

- k
