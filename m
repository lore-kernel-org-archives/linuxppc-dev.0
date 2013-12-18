Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 604102C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 06:55:09 +1100 (EST)
Date: Wed, 18 Dec 2013 20:54:59 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 1/1] powerpc/512x: dts: remove misplaced IRQ spec
 from 'soc' node (5125)
Message-ID: <20131218205459.4b6cd36a@crub>
In-Reply-To: <1386669068-2477-1-git-send-email-gsi@denx.de>
References: <1386669068-2477-1-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 10 Dec 2013 10:51:08 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> the 'soc' node in the MPC5125 "tower" board .dts has an '#interrupt-cells'
> property although this node is not an interrupt controller
> 
> remove this erroneously placed property because starting with v3.13-rc1
> lookup and resolution of 'interrupts' specs for peripherals gets misled
> (tries to use the 'soc' as the interrupt parent which fails), emits
> 'no irq domain found' WARN() messages and breaks the boot process
> 
> [ best viewed with 'git diff -U5' to have DT node names in the context ]
> 
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> 
> ---
> 
> note that this is not a resend of the previous MPC5121 fix, but instead
> is a fix for MPC5125 along the same lines of the MPC5121 fix
> ---
>  arch/powerpc/boot/dts/mpc5125twr.dts |    1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks!

Anatolij
