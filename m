Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTvy746lnzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:22:23 +1100 (AEDT)
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTvy701n2z9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:22:23 +1100 (AEDT)
Received: by mail-yw0-x243.google.com with SMTP id 203so680927ywz.1
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:22:22 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-6-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-6-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:52:00 +1030
Message-ID: <CACPK8Xf2hL7yvQZ6Ewz1-YiQeOB-XU8v=8bM8oLH=f2D8WOrmg@mail.gmail.com>
Subject: Re: [PATCH 06/12] drm/ast: Base support for AST2500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>, eich@suse.come
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 24, 2017 at 9:23 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> From: "Y.C. Chen" <yc_chen@aspeedtech.com>
>
> Add detection and mode setting updates for AST2500 generation chip,
> code originally from Aspeed and slightly reworked for coding style
> mostly by Ben. This doesn't contain the BMC DRAM POST code which
> is in a separate patch.
>
> Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>
> v2. Add 800Mhz default mclk for AST2500
> ---
>  drivers/gpu/drm/ast/ast_drv.h    |  2 ++
>  drivers/gpu/drm/ast/ast_main.c   | 32 +++++++++++++++++++---
>  drivers/gpu/drm/ast/ast_mode.c   | 30 ++++++++++++++++-----
>  drivers/gpu/drm/ast/ast_tables.h | 58 +++++++++++++++++++++++++++++++++-------
>  4 files changed, 103 insertions(+), 19 deletions(-)
>
