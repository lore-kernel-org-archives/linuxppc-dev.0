Return-Path: <Joao.Pinto@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay4.synopsys.com [198.182.47.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0TxC1tswzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:23:26 +1100 (AEDT)
Subject: Re: [PATCH 07/37] PCI: dwc: designware: Get device pointer at the
 start of dw_pcie_host_init
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-8-git-send-email-kishon@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <fbfa32a8-0897-9c8a-618c-bb41fa26c532@synopsys.com>
Date: Fri, 13 Jan 2017 17:22:44 +0000
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-8-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi!

Às 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> No functional change. Get device pointer at the beginning of
> dw_pcie_host_init instead of getting it all over dw_pcie_host_init.
> This is in preparation for splitting struct pcie_port into host and
> core structures (Once split pcie_port will not have device pointer).
> 

I think change should be condense with another patch to reduce the patch-set
number and to give it real meaning. I understand why you are breaking so much
the patch, it is has a lot of changes, but in my opinion is too much fragmented.

Thanks
Joao
