Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3252B1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 15:25:24 +1100 (AEDT)
Date: Fri, 4 Mar 2016 22:25:18 -0600
From: Rob Herring <robh@kernel.org>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, leoyang.li@nxp.com, xiaobo.xie@nxp.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/7] QE: Add IC, SI and SIRAM document to device tree
 bindings.
Message-ID: <20160305042518.GB13525@rob-hp-laptop>
References: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 01, 2016 at 03:09:37PM +0800, Zhao Qiang wrote:
> Add IC, SI and SIRAM document of QE to
> Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2
> 	- Add interrupt-controller in Required properties
> 	- delete address-cells and size-cells for qe-si and qe-siram
> Changes for v3
> 	- Add SoC specific caompatible strings to qe-si and qe-siram
> 
>  .../devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt  | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
