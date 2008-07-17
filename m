Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 95FFADE422
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 22:28:38 +1000 (EST)
Message-Id: <5F490C95-09E9-4378-B0B9-891FED7B182C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <2e3c13ddbf80969f086c92f40b1ca6cf891a738f.1216279070.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 2/3] powerpc: Use PPC_LONG_ALIGN in uaccess.h
Date: Thu, 17 Jul 2008 07:28:29 -0500
References: <3756cbfb076b2fa0b93ec990aabfee73296443d9.1216279070.git.michael@ellerman.id.au>
	<2e3c13ddbf80969f086c92f40b1ca6cf891a738f.1216279070.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2008, at 2:17 AM, Michael Ellerman wrote:

> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> include/asm-powerpc/uaccess.h |   21 +++++++++------------
> 1 files changed, 9 insertions(+), 12 deletions(-)

What's the reason for the change?

- k
