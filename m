Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMh0L6lNrzDrfT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 03:02:10 +1000 (AEST)
Received: by mail-oi0-x22b.google.com with SMTP id j203so23214706oih.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 10:02:10 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <3b3d733e-f193-b039-6113-6c0e5b44c4e7@leemhuis.info>
References: <3b3d733e-f193-b039-6113-6c0e5b44c4e7@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Aug 2016 10:02:08 -0700
Message-ID: <CA+55aFwkw9ksYnmC_c09P-iU=9OxTov2a=4+gq=xYJHsBR6avQ@mail.gmail.com>
Subject: Re: Linux 4.8: Reported regressions as of Sunday, 2016-08-28
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 28, 2016 at 8:23 AM, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Desc: irqdomain: Don't set type when mapping an IRQ breaks nexus7 gpio buttons
> Repo: 2016-07-30 https://marc.info/?l=linux-kernel&m=146985356305280&w=2
> Stat: 2016-08-12 https://marc.info/?l=linux-kernel&m=147093069326172&w=2
> Note: fix found two weeks ago, not in mainline afaics; waiting for tglx to get back?

He came back today, it's in my tree now

            Linus
