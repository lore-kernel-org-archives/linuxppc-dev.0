Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 939C51A0B50
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 07:47:24 +1100 (AEDT)
Message-ID: <1457038028.5360.98.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Mar 2016 14:47:08 -0600
In-Reply-To: <1456920999-30282-1-git-send-email-alessio.bogani@elettra.eu>
References: <1456920999-30282-1-git-send-email-alessio.bogani@elettra.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH v3 1/3] powerpc/86xx: Move dts files to fsl directory
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-02 at 13:16 +0100, Alessio Igor Bogani wrote:
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
> v2 -> v3
>     Use appropriate git format-patch flag "-M" to detect renames
> 
> v1 -> v2
>     Address suggestion made by Scott Wood
>           Split the second patch in two
>           Don't remove "fsl,mpic" which it is required for 4-cell
>             interrupt specifiers
>           Remove pointless compatible in the dtsi
>           Use the right value for pcie clock-frequency (100 Mhz)
> 
>  arch/powerpc/boot/dts/{ => fsl}/gef_ppc9a.dts        | 0
>  arch/powerpc/boot/dts/{ => fsl}/gef_sbc310.dts       | 0
>  arch/powerpc/boot/dts/{ => fsl}/gef_sbc610.dts       | 0
>  arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn.dts     | 0
>  arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn_36b.dts | 0
>  arch/powerpc/boot/dts/{ => fsl}/sbc8641d.dts         | 0
>  6 files changed, 0 insertions(+), 0 deletions(-)
>  rename arch/powerpc/boot/dts/{ => fsl}/gef_ppc9a.dts (100%)
>  rename arch/powerpc/boot/dts/{ => fsl}/gef_sbc310.dts (100%)
>  rename arch/powerpc/boot/dts/{ => fsl}/gef_sbc610.dts (100%)
>  rename arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn.dts (100%)
>  rename arch/powerpc/boot/dts/{ => fsl}/mpc8641_hpcn_36b.dts (100%)
>  rename arch/powerpc/boot/dts/{ => fsl}/sbc8641d.dts (100%)

This patchset looks OK -- were you going to send a non-RFC version?  Or do you
want me to apply this one?

-Scott
