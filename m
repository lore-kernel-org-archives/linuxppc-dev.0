Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id E4969B7D4A
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 07:14:19 +1000 (EST)
Date: Tue, 4 May 2010 23:14:18 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Oops in mpc52xx_uart_init (2.6.34-rc5)
Message-ID: <20100504231418.720eb809@wker>
In-Reply-To: <g2xc2d0b6ec1005041339r9c40822w7a642f9bba976820@mail.gmail.com>
References: <g2xc2d0b6ec1005041339r9c40822w7a642f9bba976820@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 May 2010 17:39:25 -0300
Leonardo Chiquitto <leonardo.lists@gmail.com> wrote:

> Kernel 2.6.34-rc5 crashes on boot in a ppc32 machine (Mac Mini G4).
> 
> Reverting the following commit makes the kernel boot normally again:
> 
> commit 6acc6833510db8f72b5ef343296d97480555fda9
> Author: Anatolij Gustschin <agust@denx.de>
> Date:   Tue Feb 16 22:30:03 2010 -0700
> 
>     serial: mpc52xx_uart: re-enable mpc5121 PSC UART support
> 
> I'm attaching a photo with the panic message and call trace (I apologize
> for the poor image quality and cropped left border). Please let me know if I
> can provide any other info to help debugging this issue.

Thanks for the bug report! This info is enough, I will submit a
fix soon.

Thanks,
Anatolij
