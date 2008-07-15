Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 129C8DF56D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:15:33 +1000 (EST)
Message-Id: <7041072B-324B-43D8-AD52-69961E67A396@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <1210184384-28425-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: Fix a bunch of sparse warnings in the qe_lib
Date: Tue, 15 Jul 2008 11:15:26 -0500
References: <1210184384-28425-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, timur.tabi@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2008, at 1:19 PM, Andy Fleming wrote:

> Mostly having to do with not marking things __iomem.  And some failure
> to use appropriate accessors to read MMIO regs.
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/sysdev/qe_lib/qe.c       |    6 +++---
> arch/powerpc/sysdev/qe_lib/ucc.c      |    6 +++---
> arch/powerpc/sysdev/qe_lib/ucc_fast.c |   16 ++++++++--------
> include/asm-powerpc/ucc_fast.h        |    8 ++++----
> 4 files changed, 18 insertions(+), 18 deletions(-)

applied.

- k
