Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r90VN0PVrzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 02:47:22 +1000 (AEST)
Date: Wed, 18 May 2016 11:47:16 -0500
From: Rob Herring <robh@kernel.org>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, xiaobo.xie@nxp.com
Subject: Re: [PATCH v6 3/7] QE: Add uqe_serial document to bindings
Message-ID: <20160518164716.GA32436@rob-hp-laptop>
References: <1463452743-21462-1-git-send-email-qiang.zhao@nxp.com>
 <1463452743-21462-3-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463452743-21462-3-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 17, 2016 at 10:38:59AM +0800, Zhao Qiang wrote:
> Add uqe_serial document to
> Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2
> 	- modify tx/rx-clock-name specification
> Changes for v3
> 	- NA 
> Changes for v4
> 	- drop device_type
> 	- modify to SoC specific compatible 
> Changes for v5
> 	- add fsl to compatible as prefix 
> Changes for v6
> 	- modify property to "fsl,<chip>-ucc-uart"
> 
>  .../bindings/powerpc/fsl/cpm_qe/uqe_serial.txt          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/uqe_serial.txt

Acked-by: Rob Herring <robh@kernel.org>
