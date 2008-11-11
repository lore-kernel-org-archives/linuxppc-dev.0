Return-Path: <timur.tabi@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.249])
	by ozlabs.org (Postfix) with ESMTP id 816B1DDFBA
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 04:11:20 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1282990hsz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 09:11:18 -0800 (PST)
Message-ID: <ed82fe3e0811110911o1b4bc5baqa121933cabb4f0cc@mail.gmail.com>
Date: Tue, 11 Nov 2008 11:11:18 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] powerpc/qe: Move cmxgcr_lock definition from the ucc.c
	into the qe.c
In-Reply-To: <20081111153139.GA10871@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081111153139.GA10871@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 11, 2008 at 9:31 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
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

Acked-By: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
