Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTvxM5WF3zDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:21:43 +1100 (AEDT)
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTvxM1Rxcz9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:21:43 +1100 (AEDT)
Received: by mail-yb0-x243.google.com with SMTP id d88so360467ybi.2
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:21:43 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-9-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-9-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:51:20 +1030
Message-ID: <CACPK8XcqqzeocsFfECm-61iLYWv-j8yGnmmHRwBVnhJDdqiHUA@mail.gmail.com>
Subject: Re: [PATCH 09/12] drm/ast: Rename ast_init_dram_2300 to
 ast_post_chip_2300
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
> The function does more than initializing the DRAM and in turns
> calls other functions to do the actual init. This will keeping
> things more consistent with the upcoming AST2500 POST code.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/gpu/drm/ast/ast_post.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
