Return-Path: <joel.stan@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTvxK0tQRzDqH9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:21:41 +1100 (AEDT)
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTvxJ3blfz9s7M
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:21:40 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id l16so675089ywb.2
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2017 18:21:40 -0800 (PST)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20170223225357.9572-3-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-3-benh@kernel.crashing.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 24 Feb 2017 12:51:18 +1030
Message-ID: <CACPK8Xe-e3ZghMzp03LmzPV3uXi=PCJLag743BEvhidYg56Wqg@mail.gmail.com>
Subject: Re: [PATCH 03/12] drm/ast: const'ify mode setting tables
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
> And fix some comment alignment & space/tabs while at it
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/gpu/drm/ast/ast_drv.h    |   4 +-
>  drivers/gpu/drm/ast/ast_mode.c   |   8 +--
>  drivers/gpu/drm/ast/ast_tables.h | 106 +++++++++++++++++++--------------------
>  3 files changed, 59 insertions(+), 59 deletions(-)
