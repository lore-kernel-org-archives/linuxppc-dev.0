Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C296E1A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Dec 2014 20:02:04 +1100 (AEDT)
Message-ID: <1419843704.30395.4.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/smp: Fix Non-boot cpus cannot be bring up.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
In-Reply-To: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
References: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Dec 2014 20:01:44 +1100
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-22 at 14:38 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Kernel cannot bring up Non-boot cpus always get "Processor xx is stuck".
> this issue bring by http://patchwork.ozlabs.org/patch/418912/ (powerpc:
> Secondary CPUs must set cpu_callin_map after setting active and online)

We've decided we're just going to revert that patch for this cycle.

We'll do a better fix for next, and hopefully people will test it before it
gets to mainline :D

cheers
