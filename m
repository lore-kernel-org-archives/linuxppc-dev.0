Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYKrh3FbFzDvyN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 11:59:16 +1100 (AEDT)
Date: Tue, 6 Dec 2016 18:59:04 -0600
From: Scott Wood <oss@buserror.net>
To: Madalin Bucur <madalin.bucur@nxp.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20161207005904.GA12811@home.buserror.net>
References: <1481030019-31854-2-git-send-email-madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481030019-31854-2-git-send-email-madalin.bucur@nxp.com>
Subject: Re: [v2, 2/3] powerpc/fsl/dts: add QMan and BMan portal nodes on t1024
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 06, 2016 at 03:13:38PM +0200, Madalin Bucur wrote:
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  arch/powerpc/boot/dts/fsl/t1024qds.dts | 29 +++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t1024rdb.dts | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)

So, in patch 1/3 you add qman and bman nodes to t1023si-post.dtsi and
call it "add QMan and BMan portal nodes on t1023rdb" as if it were
board-specific (the only board-specific part is the reserved-memory
nodes, not the portals).

Then, in this patch you only touch board-specific files, and label it
"add QMan and BMan portal nodes on t1024"...

> diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
> index 302cdd2..73a6453 100644
> --- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
> +++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
> @@ -41,6 +41,31 @@
>  	#size-cells = <2>;
>  	interrupt-parent = <&mpic>;
>  
> +	aliases {
> +		sg_2500_aqr105_phy4 = &sg_2500_aqr105_phy4;
> +	};

What does this have to do with the qman and bman portal nodes?  Why is
this alias needed?

-Scott
