Return-Path: <Joao.Pinto@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay4.synopsys.com [198.182.47.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0T2R0p8JzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 03:42:54 +1100 (AEDT)
Subject: Re: [PATCH 04/37] PCI: dwc: designware: Move the register defines to
 designware header file
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-5-git-send-email-kishon@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <0913dcb3-ecb8-b926-981d-f5d3baa9d8b7@synopsys.com>
Date: Fri, 13 Jan 2017 16:35:03 +0000
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-5-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Às 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> No functional change. Move the register defines and other macros from
> pcie-designware.c to pcie-designware.h. This is in preparation to
> split the pcie-designware.c file into designware core file and host
> specific file.
> 
> While at that also fix a checkpatch warning.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pcie-designware.c |   70 ------------------------------------
>  drivers/pci/dwc/pcie-designware.h |   71 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> index d68bc7b..0b928dc 100644
> --- a/drivers/pci/dwc/pcie-designware.c
> +++ b/drivers/pci/dwc/pcie-designware.c
> @@ -25,76 +25,6 @@
>  
>  #include "pcie-designware.h"

Make sense.

Reviewed-By: Joao Pinto <jpinto@synopsys.com>
