Return-Path: <linus971@gmail.com>
Received: from mail-io0-x236.google.com (mail-io0-x236.google.com
 [IPv6:2607:f8b0:4001:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vgVtR5sPQzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 04:07:27 +1100 (AEDT)
Received: by mail-io0-x236.google.com with SMTP id z13so64970721iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2017 09:07:27 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170310023351.973-1-Larry.Finger@lwfinger.net>
References: <20170310023351.973-1-Larry.Finger@lwfinger.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 Mar 2017 09:07:24 -0800
Message-ID: <CA+55aFzHpFA5GmCD0BB1jKwrpaze7g4qwEbZPF55bnQozCE81Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix crash introduced with commit 5657933dbb6e
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "regressions @ leemhuis . info" <regressions@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 9, 2017 at 6:33 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> The problem was bisected to commit 5657933dbb6e ("treewide: Move dma_ops
> from struct dev_archdata into struct device"). The problem was a missing
> copy of critical information from struct dev_archdata into struct device,
> leading to the dereference of a null pointer.
>
> This fix was suggested by Benjamin Herrenschmidt.

I'm assuming I'll be getting this through the powerpc tree. Holler if
that isn't the case.

                Linus
