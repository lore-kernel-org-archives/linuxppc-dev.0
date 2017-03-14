Return-Path: <linus971@gmail.com>
Received: from mail-it0-x22d.google.com (mail-it0-x22d.google.com
 [IPv6:2607:f8b0:4001:c0b::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjPxr5Q01zDqfV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 06:32:00 +1100 (AEDT)
Received: by mail-it0-x22d.google.com with SMTP id m27so12817001iti.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 12:32:00 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <5d399102-c648-7a87-1dff-f8b74c12ceaa@leemhuis.info>
References: <5d399102-c648-7a87-1dff-f8b74c12ceaa@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Mar 2017 12:31:57 -0700
Message-ID: <CA+55aFxjM_zE7Xum-WGYADUQqdY2FyfM+ra=s+gWK5hz=hoxCQ@mail.gmail.com>
Subject: Re: Linux 4.11: Reported regressions as of Tuesday, 20176-03-14
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

On Tue, Mar 14, 2017 at 3:02 AM, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Desc: PowerPC crashes on boot, bisected to commit 5657933dbb6e
> Repo: 2017-03-02 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1343553.html
> Stat: 2017-03-09 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1349568.html
> Note: patch hopefully heading mainline

Should already be mainline as commit 46f401c4297a ("powerpc/pmac: Fix
crash in dma-mapping.h with NULL dma_ops") but didn't make rc2.

               Linus
