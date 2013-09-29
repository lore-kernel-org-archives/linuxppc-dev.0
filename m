Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 8C55D2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 09:56:21 +1000 (EST)
Received: from mail-ve0-f169.google.com (mail-ve0-f169.google.com
 [209.85.128.169])
 by muin.pair.com (Postfix) with ESMTPSA id 6EBF98FC3E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 19:56:19 -0400 (EDT)
Received: by mail-ve0-f169.google.com with SMTP id db12so3520369veb.14
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 16:56:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
 <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
Date: Sun, 29 Sep 2013 18:56:18 -0500
Message-ID: <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
From: Timur Tabi <timur@tabi.org>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zang Roy-R61911 <r61911@freescale.com>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 18, 2013 at 6:02 AM, Minghuan Lian
<Minghuan.Lian@freescale.com> wrote:

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 38f3b7e..6fd6348 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -690,6 +690,7 @@ config FSL_SOC
>
>  config FSL_PCI
>         bool
> +       select PCI_FSL if FSL_SOC_BOOKE || PPC_86xx

I think having two config options, one called FSL_PCI and the other
PCI_FSL, is very confusing.  Surely, you can pick better names than
that?
