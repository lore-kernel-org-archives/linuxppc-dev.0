Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 9E321DDF47
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 23:25:28 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so347576anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 09 May 2008 06:25:26 -0700 (PDT)
Message-ID: <fa686aa40805090625m1f127898j19e3f2436ef0fbc6@mail.gmail.com>
Date: Fri, 9 May 2008 07:25:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jason Jin" <Jason.jin@freescale.com>
Subject: Re: [PATCH 1/4 V2] booting-without-of for Freescale MSI
In-Reply-To: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 9, 2008 at 3:03 AM, Jason Jin <Jason.jin@freescale.com> wrote:
> Binding document adding for Freescale MSI support.
>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> ---
> Updated to V2 version per Segher's suggestion.
>
>  Documentation/powerpc/booting-without-of.txt |   40 +++++++++++++++++++++++++-
>  1 files changed, 39 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 1d2a772..887783c 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -57,7 +57,10 @@ Table of Contents
>       n) 4xx/Axon EMAC ethernet nodes
>       o) Xilinx IP cores
>       p) Freescale Synchronous Serial Interface
> -         q) USB EHCI controllers
> +      q) USB EHCI controllers
> +      r) Freescale Display Interface Unit
> +      s) Freescale on board FPGA
> +      t) Freescael MSI interrupt controller
>
>   VII - Marvell Discovery mv64[345]6x System Controller chips
>     1) The /system-controller node
> @@ -2870,6 +2873,41 @@ platforms are moved over to use the flattened-device-tree model.
>                reg = <0xe8000000 32>;
>        };
>
> +    t) Freescale MSI interrupt controller
> +
> +    Reguired properities:
> +    - compatible : set as "fsl,86xx-MSI" for 86xx cpu, "fsl,85xx-MSI" for 85xx
> +      cpu and "fsl,83xx-MSI" for 83xx cpu.

As Segher mentioned; don't use 'generic' compatible values.  Use names
of *actual* devices and have newer parts claim compatibility with
older ones.

Otherwise looks good to me.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
