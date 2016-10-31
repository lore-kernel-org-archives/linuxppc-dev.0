Return-Path: <linus971@gmail.com>
Received: from mail-oi0-x22e.google.com (mail-oi0-x22e.google.com
 [IPv6:2607:f8b0:4003:c06::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t71YK2h7XzDvM3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 04:28:37 +1100 (AEDT)
Received: by mail-oi0-x22e.google.com with SMTP id i127so240597788oia.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 10:28:37 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <0eb29167-7908-e049-6927-d9c6b093970d@leemhuis.info>
References: <0eb29167-7908-e049-6927-d9c6b093970d@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Oct 2016 10:28:32 -0700
Message-ID: <CA+55aFxKgWPj6FS+Bi-B=9N+yLka29rh5+Nd55j--mMe_6vJ5g@mail.gmail.com>
Subject: Re: Linux 4.9: Reported regressions as of Sunday, 2016-10-30
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

On Sun, Oct 30, 2016 at 6:20 AM, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Desc: tpm0: TPM self test failed
> Repo: 2016-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1259943.html
> Stat: 2016-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1260452.html https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1256705.html
> Note: Fix hopefully soon heading upstream
>
> Desc: "Nokia N900 (omap3-n900) with ""VDD1: ramp_delay not set"" string in printk frequently"
> Repo: 2016-10-19 https://bugzilla.kernel.org/show_bug.cgi?id=178371
> Stat: n/a https://lkml.org/lkml/2016/10/27/527
> Note: discussion on lkml ongoing

These two should hopefully be fixed as of today in current -git.

> Desc: radeon performance drop from 4.8 to 4.9-rc1 in Shadow of Mordor
> Repo: 2016-10-14 https://bugzilla.kernel.org/show_bug.cgi?id=178221 https://lists.freedesktop.org/archives/dri-devel/2016-October/120693.html
> Stat: 2016-10-20 https://lists.freedesktop.org/archives/dri-devel/2016-October/121427.html
> Note: Stuck? Poked bugzilla

I think this was fixed Friday by the merge of the PAT regression fixes
from DaveA (merge commit .bdb520845b57)

               Linus
