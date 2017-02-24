Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTw0910GmzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:24:09 +1100 (AEDT)
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTw083t3wz9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:24:08 +1100 (AEDT)
Received: by mail-yw0-x241.google.com with SMTP id 2so672810ywn.3
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:24:08 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-1-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:53:46 +1030
Message-ID: <CACPK8Xf10buN=sjdcvD+WwXK_YvSFDY1U_sg0M2gtBDa9Wz52A@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/ast: Fix AST2400 POST failure without BMC FW or
 VBIOS
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
> The current POST code for the AST2300/2400 family doesn't work properly
> if the chip hasn't been initialized previously by either the BMC own FW
> or the VBIOS. This fixes it.
>
> Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/gpu/drm/ast/ast_post.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
