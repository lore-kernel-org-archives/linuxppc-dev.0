Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd3Xn3M8gzDr8c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 01:29:29 +1100 (AEDT)
Received: by mail-ot0-f193.google.com with SMTP id 18so22639243oty.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 06:29:29 -0800 (PST)
Date: Thu, 16 Nov 2017 08:29:26 -0600
From: Rob Herring <robh@kernel.org>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] libnvdimm: Add a device-tree interface
Message-ID: <20171116142926.cdvx2st72tnu7gi7@rob-hp-laptop>
References: <20171115175131.23631-1-oohall@gmail.com>
 <20171115175131.23631-2-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171115175131.23631-2-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2017 at 04:51:30AM +1100, Oliver O'Halloran wrote:
> A fairly bare-bones set of device-tree bindings so libnvdimm can be used
> on powerpc and other device-tree based platforms.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
>  .../devicetree/bindings/nvdimm/nvdimm-bus.txt      |  69 +++++++

Also, please split bindings to a separate patch.

>  MAINTAINERS                                        |   8 +
>  drivers/nvdimm/Kconfig                             |  10 +
>  drivers/nvdimm/Makefile                            |   1 +
>  drivers/nvdimm/of_nvdimm.c                         | 202 +++++++++++++++++++++
>  5 files changed, 290 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvdimm/nvdimm-bus.txt
>  create mode 100644 drivers/nvdimm/of_nvdimm.c
