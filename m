Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpCJt0b3tzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 01:50:06 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 1AD37203A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:50:03 +0000 (UTC)
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
 [209.85.161.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C7362038F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:50:01 +0000 (UTC)
Received: by mail-yw0-f176.google.com with SMTP id i203so15309378ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 07:50:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490154573-22475-1-git-send-email-alistair@popple.id.au>
References: <1490154573-22475-1-git-send-email-alistair@popple.id.au>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 22 Mar 2017 09:49:40 -0500
Message-ID: <CAL_JsqK1N98e0=ECs7+xY=16niPtp86BkNC09EMsXFkm90dafw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers/of/base.c: Add of_property_read_u64_index
To: Alistair Popple <alistair@popple.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mhairgrove@nvidia.com, shailendras@nvidia.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 21, 2017 at 10:49 PM, Alistair Popple <alistair@popple.id.au> wrote:
> There is of_property_read_u32_index but no u64 variant. This patch
> adds one similar to the u32 version for u64.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  drivers/of/base.c  | 31 +++++++++++++++++++++++++++++++
>  include/linux/of.h |  3 +++
>  2 files changed, 34 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
