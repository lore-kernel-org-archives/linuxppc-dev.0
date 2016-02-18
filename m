Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com
 [IPv6:2a00:1450:400c:c09::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0A4D1A0620
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 08:18:26 +1100 (AEDT)
Received: by mail-wm0-x235.google.com with SMTP id g62so44289657wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 13:18:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1455708258-3831-1-git-send-email-raghav.dogra@nxp.com>
References: <1455708258-3831-1-git-send-email-raghav.dogra@nxp.com>
Date: Thu, 18 Feb 2016 15:18:21 -0600
Message-ID: <CADRPPNS1i1XgtpyiT_=rDuDXBDn=ehNY32=RKTC9hdKXhWWq8A@mail.gmail.com>
Subject: Re: [PATCH][v3] mtd/ifc: Add support for IFC controller version 2.0
From: Leo Li <pku.leo@gmail.com>
To: Raghav Dogra <raghav.dogra@nxp.com>
Cc: linux-mtd@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>, Scott Wood <oss@buserror.net>,
 Brian Norris <computersforpeace@gmail.com>, Raghav Dogra <raghav@freescale.com>,
 Jaiprakash Singh <b44839@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 17, 2016 at 5:24 AM, Raghav Dogra <raghav.dogra@nxp.com> wrote:
> The new IFC controller version 2.0 has a different memory map page.
> Upto IFC 1.4 PAGE size is 4 KB and from IFC2.0 PAGE size is 64KB.
> This patch segregates the IFC global and runtime registers to appropriate
> PAGE sizes.
>
> Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> Signed-off-by: Raghav Dogra <raghav@freescale.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Raghav Dogra <raghav.dogra@nxp.com>
> ---
> Changes for v3: not dependent on
> "drivers/memory: Add deep sleep support for IFC" patch
>
> Changes for v2: rebased to resolve conflicts
> Applicable to git://git.infradead.org/l2-mtd.git
>
> This patch is dependent on "drivers/memory: Add deep sleep support for IFC"
> https://patchwork.ozlabs.org/patch/582762/
> which is also applicable to git://git.infradead.org/l2-mtd.git

This patch seems to be in good shape, but the dependency is still
having quite some feedback to be addressed.  Depending on it will
greatly delay the time that this critical patch for LS2 to be merged.
Could you remove the dependency like Scott already suggested?

Regards,
Leo
