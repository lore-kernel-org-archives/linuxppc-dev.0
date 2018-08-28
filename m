Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qt0-x230.google.com (mail-qt0-x230.google.com
 [IPv6:2607:f8b0:400d:c0d::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4201Hx6QWCzDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 17:54:53 +1000 (AEST)
Received: by mail-qt0-x230.google.com with SMTP id o15-v6so667757qtk.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 00:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-50-robh@kernel.org>
In-Reply-To: <20180828015252.28511-50-robh@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 Aug 2018 10:54:39 +0300
Message-ID: <CAHp75VeBTdugxXeM9wj=x-JarLqRcmZzwDLav71RM66FcP-xjQ@mail.gmail.com>
Subject: Re: [PATCH] sound: Convert to using %pOFn instead of device_node.name
To: Rob Herring <robh@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2018 at 4:56 AM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

> +       if (snprintf(node_name, sizeof(node_name), "%pOFn", np) != 5)
>                 return 0;

> +       if (strncmp(np, "i2s-", 4))
>                 return 0;

Shouldn't be node_name here?



-- 
With Best Regards,
Andy Shevchenko
