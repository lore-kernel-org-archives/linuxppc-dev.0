Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 209B7DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 02:52:48 +1100 (EST)
Message-Id: <70FD88FA-3F16-4EE5-B88E-9DCF557885F2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081111153139.GA10871@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/qe: Move cmxgcr_lock definition from the ucc.c
	into the qe.c
Date: Wed, 3 Dec 2008 09:50:38 -0600
References: <20081111153139.GA10871@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 11, 2008, at 9:31 AM, Anton Vorontsov wrote:

> With this patch we can compile the qe_lib/usb.c without the UCC
> support (that is, without UCC_GETH and/or SERIAL_QE).
>
> Fixes following link error (CONFIG_SMP should be =y to trigger this):
>
> arch/powerpc/sysdev/built-in.o: In function `qe_usb_clock_set':
> (.text+0x3cae): undefined reference to `cmxgcr_lock'
> make: *** [.tmp_vmlinux1] Error 1
>
> While at it, also add missing spinlock.h includes.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> This is for powerpc-next since nobody enables QE_USB yet.
>
> arch/powerpc/sysdev/qe_lib/qe.c  |    3 +++
> arch/powerpc/sysdev/qe_lib/ucc.c |    4 +---
> 2 files changed, 4 insertions(+), 3 deletions(-)

applied to next.

- k
