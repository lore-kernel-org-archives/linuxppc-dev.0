Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 186862C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 00:07:59 +1100 (EST)
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by muin.pair.com (Postfix) with ESMTPSA id 999088FC30
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 09:07:56 -0400 (EDT)
Received: by mail-la0-f44.google.com with SMTP id eb20so3749283lab.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 06:07:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
Date: Fri, 15 Mar 2013 08:07:54 -0500
Message-ID: <CAOZdJXV5UgT71j5XJH8K6DnfE-SUVL2jE7yNZUhE+gstb_33tQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860QDS
From: Timur Tabi <timur@tabi.org>
To: Shaveta Leekha <shaveta@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>,
 Tang Yuantian <Yuantian.Tang@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Andy Fleming <afleming@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 15, 2013 at 2:55 AM, Shaveta Leekha <shaveta@freescale.com> wrote:


> +       iommu@20000 {
> +               compatible = "fsl,pamu-v1.0", "fsl,pamu";
> +               reg = <0x20000 0x4000>;
> +               interrupts = <
> +                       24 2 0 0
> +                       16 2 1 1>;
> +       };

You need to add the PAMU topology.

-- 
Timur Tabi
Linux kernel developer at Freescale
