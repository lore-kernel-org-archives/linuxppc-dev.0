Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 807BEDE3EF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 02:11:36 +1000 (EST)
Message-Id: <D0AA92CE-DC06-42FC-B1B9-A17002083881@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080611123248.GA8207@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/QE: qe_reset should be __init
Date: Wed, 11 Jun 2008 11:11:31 -0500
References: <20080611123248.GA8207@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 11, 2008, at 7:32 AM, Anton Vorontsov wrote:

> This patch fixes following section mismatch:
>
> WARNING: arch/powerpc/sysdev/built-in.o(.text+0x11d8): Section  
> mismatch in
> reference from the function qe_reset() to the function
> .init.text:cpm_muram_init()
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/qe_lib/qe.c |    2 +-
> include/asm-powerpc/qe.h        |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

applied.

- k
