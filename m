Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4xK60DPrzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 03:10:34 +1000 (AEST)
Received: by mail-oi0-f65.google.com with SMTP id l9so26461834oih.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 10:10:33 -0700 (PDT)
Date: Thu, 4 Aug 2016 12:10:30 -0500
From: Rob Herring <robh@kernel.org>
To: Chenhui Zhao <chenhui.zhao@nxp.com>
Cc: oss@buserror.net, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jason.jin@nxp.com, z.chenhui@gmail.com
Subject: Re: [PATCH v3 1/5] powerpc/dts: add mcke-gpios for PM feature
Message-ID: <20160804171030.GA12055@rob-hp-laptop>
References: <1470139124-12652-1-git-send-email-chenhui.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470139124-12652-1-git-send-email-chenhui.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2016 at 07:58:44PM +0800, Chenhui Zhao wrote:
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 13 +++++++++++++
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  3 +++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> index e284e4e..1d44a80 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> @@ -21,6 +21,10 @@ Required properites:
>  	* "fsl,qoriq-rcpm-2.0": for chassis 2.0 rcpm
>  	* "fsl,qoriq-rcpm-2.1": for chassis 2.1 rcpm
>  
> +Optional properites:
> +  - mcke-gpios : The GPIO pin is used for keeping the MCKE signal of DDR modules
> +		 low in the LPM35 state on some platforms, such as T1040.

Needs a vendor prefix.
