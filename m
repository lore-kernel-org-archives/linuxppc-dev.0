Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-x234.google.com (mail-yw0-x234.google.com
 [IPv6:2607:f8b0:4002:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6110D1A035B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 02:00:15 +1100 (AEDT)
Received: by mail-yw0-x234.google.com with SMTP id g127so14855176ywf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 07:00:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-43-git-send-email-gwshan@linux.vnet.ibm.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 17 Feb 2016 08:59:53 -0600
Message-ID: <CAL_JsqJydgmkU=SGcr-0JHsYG8wXk5GEQCQXY7y+FHH2A0LZkw@mail.gmail.com>
Subject: Re: [PATCH v8 42/45] drivers/of: Rename unflatten_dt_node()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
 dja@axtens.net, Bjorn Helgaas <bhelgaas@google.com>,
 Grant Likely <grant.likely@linaro.org>
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
> This renames unflatten_dt_node() to unflatten_dt_nodes() as it
> populates multiple device nodes from FDT blob. No logical changes
> introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  drivers/of/fdt.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

I'm happy to take patches 40-42 for 4.6 if the rest of the series
doesn't go in given they fix a separate problem. I just need to know
soon (or at least they need to go into -next soon).

Rob
