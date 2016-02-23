Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C834F1A08DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 07:25:00 +1100 (AEDT)
Date: Tue, 23 Feb 2016 14:24:50 -0600
From: Rob Herring <robh@kernel.org>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/7] bindings: move cpm_qe binding from powerpc/fsl to
 soc/fsl
Message-ID: <20160223202450.GA10076@rob-hp-laptop>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
 <1455757572-44955-4-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455757572-44955-4-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 18, 2016 at 09:06:09AM +0800, Zhao Qiang wrote:
> cpm_qe is supported on both powerpc and arm.
> and the QE code has been moved from arch/powerpc into
> drivers/soc/fsl, so move cpm_qe binding from powerpc/fsl
> to soc/fsl
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2
> 	- new added
> 
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm.txt     | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/brg.txt | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/i2c.txt | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/pic.txt | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/usb.txt | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/gpio.txt    | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/network.txt | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe.txt      | 0
>  .../devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/firmware.txt       | 0
>  .../devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/par_io.txt         | 0
>  .../devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/pincfg.txt         | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/ucc.txt  | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/usb.txt  | 0
>  Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/serial.txt  | 0
>  .../devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/uqe_serial.txt        | 0
>  15 files changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/brg.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/i2c.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/pic.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/usb.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/gpio.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/network.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/firmware.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/par_io.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/pincfg.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/ucc.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/usb.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/serial.txt (100%)
>  rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/uqe_serial.txt (100%)

Acked-by: Rob Herring <robh@kernel.org>
