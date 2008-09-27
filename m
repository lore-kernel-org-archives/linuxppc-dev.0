Return-Path: <dan.j.williams@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id C867EDDDD8
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Sep 2008 04:13:22 +1000 (EST)
Received: by gxk14 with SMTP id 14so9034105gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Sep 2008 11:13:20 -0700 (PDT)
Message-ID: <e9c3a7c20809271113n31e00d4ax424a35d9b0836928@mail.gmail.com>
Date: Sat, 27 Sep 2008 11:13:20 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH v2] fsl-dma: allow Freescale Elo DMA driver to be compiled
	as a module
In-Reply-To: <1222293567-17694-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1222293567-17694-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2008 at 2:59 PM, Timur Tabi <timur@freescale.com> wrote:
> Modify the Freescale Elo / Elo Plus DMA driver so that it can be compiled as
> a module.
>
> The primary change is to stop treating the DMA controller as a bus, and the
> DMA channels as devices on the bus.  This is because the Open Firmware (OF)
> kernel code does not allow busses to be removed, so although we can call
> of_platform_bus_probe() to probe the DMA channels, there is no
> of_platform_bus_remove().  Instead, the DMA channels are manually probed,
> similar to what fsl_elbc_nand.c does.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied to async_tx.git/next.

--
Dan
