Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xytdH0rMHzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 09:49:04 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id i130so4230592pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 16:49:02 -0700 (PDT)
Date: Thu, 21 Sep 2017 18:32:34 -0500
From: Rob Herring <robh@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, marc.zyngier@arm.com,
 mark.rutland@arm.com, bhelgaas@google.com, shawnguo@kernel.org,
 Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, roy.zang@nxp.com
Subject: Re: [PATCH 3/5] PCI: layerscape: Add support for ls1012a
Message-ID: <20170921233234.vlmjm3hw3egr7zag@rob-hp-laptop>
References: <20170919092658.22482-1-Zhiqiang.Hou@nxp.com>
 <20170919092658.22482-4-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170919092658.22482-4-Zhiqiang.Hou@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2017 at 05:26:56PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  drivers/pci/dwc/pci-layerscape.c                         | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
