Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF3921A035C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Mar 2016 15:25:33 +1100 (AEDT)
Date: Fri, 4 Mar 2016 22:25:25 -0600
From: Rob Herring <robh@kernel.org>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, leoyang.li@nxp.com, xiaobo.xie@nxp.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/7] QE: Add ucc hdlc document to bindings
Message-ID: <20160305042525.GC13525@rob-hp-laptop>
References: <1456816183-22340-1-git-send-email-qiang.zhao@nxp.com>
 <1456816183-22340-2-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456816183-22340-2-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 01, 2016 at 03:09:38PM +0800, Zhao Qiang wrote:
> Add ucc hdlc document to
> Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2
> 	- use ucc-hdlc instead of ucc_hdlc
> 	- add more information to properties.
> Changes for v3
> 	- use fsl,tx-timeslot-mask instead of fsl,tx-timeslot 
> 	- use fsl,rx-timeslot-mask instead of fsl,rx-timeslot 
> 	- add more info
> 
>  .../bindings/powerpc/fsl/cpm_qe/network.txt        | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
