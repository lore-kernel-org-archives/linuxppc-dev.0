Return-Path: <timur.tabi@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.233])
	by ozlabs.org (Postfix) with ESMTP id 2D716DDF95
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 06:09:34 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so127638wra.1
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 13:09:33 -0700 (PDT)
Message-ID: <ed82fe3e0809041309h29d0c1faw77083e95040bbfbc@mail.gmail.com>
Date: Thu, 4 Sep 2008 15:09:33 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: add SSI-to-DMA properties to Freescale MPC8610
	HPCD device tree
In-Reply-To: <1218041305-5298-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1218041305-5298-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 11:48 AM, Timur Tabi <timur@freescale.com> wrote:
> Add the fsl,playback-dma and fsl,capture-dma properties to the Freescale
> MPC8610 HPCD device tree.  These properties connect the SSI nodes to the
> DMA nodes for the DMA channels that the SSI should use.  Also update the
> ssi.txt documentation.
>
> These properties will be needed when the ASoC V2 version of the Freescale
> MPC8610 device drivers are merged into the mainline.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---

Kumar, any thoughts on this patch?

-- 
Timur Tabi
Linux kernel developer at Freescale
