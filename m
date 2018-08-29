Return-Path: <pku.leo@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4210wc5FxTzF35K
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 08:41:36 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id t68-v6so12050398oie.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 15:41:35 -0700 (PDT)
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com.
 [209.85.218.49])
 by smtp.gmail.com with ESMTPSA id p7-v6sm4051542oif.35.2018.08.29.15.41.33
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Aug 2018 15:41:33 -0700 (PDT)
Received: by mail-oi0-f49.google.com with SMTP id 13-v6so12128433ois.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 15:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180604115842.7c4vzge3igjbnblt@kili.mountain>
 <CA+7wUszWKm+qZQ7CQu3Kn7-aYeM-hSet03_PEh8EswNn141nyw@mail.gmail.com>
 <20180829093948.c7nbl27ju4uszrum@mwanda>
In-Reply-To: <20180829093948.c7nbl27ju4uszrum@mwanda>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 29 Aug 2018 17:41:21 -0500
Message-ID: <CADRPPNSO6bWwaEm9j9VpsTqujroSHVS-=bkCvWzAC2B2oTcctQ@mail.gmail.com>
Subject: Re: [PATCH] fsl/qe: ucc: copy and paste bug in
 ucc_get_tdm_sync_shift()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: malat@debian.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 kernel-janitors@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Zhao Qiang <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2018 at 4:42 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Jun 04, 2018 at 02:06:45PM +0200, Mathieu Malaterre wrote:
> > Where did the original go ?
> >
> > https://patchwork.ozlabs.org/patch/868158/
> >
> >
>
> Btw, we still haven't pushed a patch for this bug.

I will combine Zhao Qiang's patch with your description which is
better, and push as fix for 4.19.

Regards,
Leo
