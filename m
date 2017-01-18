Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3gJy6FgMzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 08:36:34 +1100 (AEDT)
Received: by mail-ot0-f195.google.com with SMTP id f9so2435373otd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 13:36:34 -0800 (PST)
Date: Wed, 18 Jan 2017 15:36:31 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 25/37] dt-bindings: PCI: Add dt bindings for pci
 designware EP mode
Message-ID: <20170118213631.vvdjc4g3gt6zy2c5@rob-hp-laptop>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-26-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484216786-17292-26-git-send-email-kishon@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2017 at 03:56:14PM +0530, Kishon Vijay Abraham I wrote:
> Add device tree binding documentation for pci designware EP mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/designware-pcie.txt    |   26 ++++++++++++++------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
