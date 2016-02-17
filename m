Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-x233.google.com (mail-yw0-x233.google.com
 [IPv6:2607:f8b0:4002:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93CCD1A0475
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 02:00:53 +1100 (AEDT)
Received: by mail-yw0-x233.google.com with SMTP id h129so14866970ywb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 07:00:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-44-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-44-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 17 Feb 2016 09:00:31 -0600
Message-ID: <CAL_JsqLLrp+ZxkhEp9Whg=jhm4-Cq4-GpRVerj4h6igzRQXiEQ@mail.gmail.com>
Subject: Re: [PATCH v8 43/45] drivers/of: Specify parent node in
 of_fdt_unflatten_tree()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
 Grant Likely <grant.likely@linaro.org>, Jyri Sarha <jsarha@ti.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 9:44 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> This adds one more argument to of_fdt_unflatten_tree() to specify
> the parent node of the FDT blob that is going to be unflattened.
> In the result, the function can be used to unflatten FDT blob that
> represents device sub-tree in PowerNV PCI hotplug driver.
>
> Cc: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_slave_compat.c |  2 +-
>  drivers/of/fdt.c                             | 14 ++++++++++----
>  drivers/of/unittest.c                        |  2 +-
>  include/linux/of_fdt.h                       |  1 +
>  4 files changed, 13 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
