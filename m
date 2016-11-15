Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHxzb4tXTzDvhM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 17:18:51 +1100 (AEDT)
Message-ID: <1479190722.21746.33.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: madalin.bucur@nxp.com, devicetree@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Date: Tue, 15 Nov 2016 00:18:42 -0600
In-Reply-To: <1478879598-3362-3-git-send-email-madalin.bucur@nxp.com>
References: <1478879598-3362-1-git-send-email-madalin.bucur@nxp.com>
 <1478879598-3362-3-git-send-email-madalin.bucur@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] powerpc/fsl/dts: add FMan node for t1042d4rdb
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-11-11 at 17:53 +0200, Madalin Bucur wrote:
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  arch/powerpc/boot/dts/fsl/t1042d4rdb.dts | 47
> ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
> b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
> index 2a5a90d..8c0c318 100644
> --- a/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
> +++ b/arch/powerpc/boot/dts/fsl/t1042d4rdb.dts
> @@ -48,6 +48,53 @@
>  					"fsl,deepsleep-cpld";
>  		};
>  	};
> +	soc: soc@ffe000000 {

Please leave a blank line between nodes, especially here at the top level.

-Scott
