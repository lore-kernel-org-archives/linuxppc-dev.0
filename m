Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACB661A0B85
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 15:25:47 +1100 (AEDT)
Date: Fri, 4 Mar 2016 22:25:41 -0600
From: Rob Herring <robh@kernel.org>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, leoyang.li@nxp.com, xiaobo.xie@nxp.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 4/7] bindings: move cpm_qe binding from powerpc/fsl to
 soc/fsl
Message-ID: <20160305042541.GE13525@rob-hp-laptop>
References: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
 <1456816183-22340-4-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456816183-22340-4-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 01, 2016 at 03:09:40PM +0800, Zhao Qiang wrote:
> cpm_qe is supported on both powerpc and arm.
> and the QE code has been moved from arch/powerpc into
> drivers/soc/fsl, so move cpm_qe binding from powerpc/fsl
> to soc/fsl
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---

I already acked this. In the future, please add acks on subsequent revs.

Acked-by: Rob Herring <robh@kernel.org>
