Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B3CBDE17E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 00:09:19 +1000 (EST)
Message-Id: <C05CA179-C72C-4BAB-8EFE-6D326B9E130D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <f05ebfb9b74b4244142895b4252be6a70905e69e.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 10/14] powerpc: Consolidate feature fixup macros for 64/32
	bit
Date: Tue, 24 Jun 2008 08:48:35 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<f05ebfb9b74b4244142895b4252be6a70905e69e.1214271072.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2008, at 8:32 PM, Michael Ellerman wrote:

> Currentl we have three versions of MAKE_FTR_SECTION_ENTRY(), the  
> macro that
> generates a feature section entry. There is 64bit version, a 32bit  
> version
> and version for 32bit code built with a 64bit kernel.

typo in 'currentl'
>
>
> Rather than triplicating (?) the MAKE_FTR_SECTION_ENTRY() logic, we  
> can
> move the 64bit/32bit differences into separate macros, and then only  
> have
> one version of MAKE_FTR_SECTION_ENTRY().
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> include/asm-powerpc/feature-fixups.h |   54 +++++++ 
> +-------------------------
> 1 files changed, 13 insertions(+), 41 deletions(-)


Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
