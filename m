Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTvxh1ghczDqGj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:22:00 +1100 (AEDT)
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTvxg40kqz9s7R
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:21:59 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id q127so684941ywg.0
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:21:59 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-12-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-12-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:51:37 +1030
Message-ID: <CACPK8XeYw94sFOTAN2Hdku8JrqKZuX42C+LGAWhdXAKTJPq8QQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] drm/ast: Call open_key before enable_mmio in POST
 code
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
> open_key enables access the registers used by enable_mmio
>
> Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/gpu/drm/ast/ast_post.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
