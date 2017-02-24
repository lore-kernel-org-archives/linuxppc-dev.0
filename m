Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTw1J6Tk7zDqHy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:25:08 +1100 (AEDT)
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTw1H5q95z9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:25:07 +1100 (AEDT)
Received: by mail-yb0-x243.google.com with SMTP id i66so364361yba.1
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:25:07 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-7-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-7-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:54:45 +1030
Message-ID: <CACPK8Xcw7HrbnmZvx=Mxq+FZK=qnAuPNQWzSeYCeiaZYZLrpBQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] drm/ast: Fixed vram size incorrect issue on POWER
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>, eich@suse.com
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
> The default value of VGA scratch may incorrect.
> Should initial h/w before get vram info.
>
> Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/gpu/drm/ast/ast_main.c | 6 +++---
>  drivers/gpu/drm/ast/ast_post.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
