Return-Path: <srs0=sfmu=jf=gmail.com=linus971@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419Ng829qqzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 08:58:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 419Ng81LmRz8t2S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 08:58:44 +1000 (AEST)
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 419Ng71yBnz9s3M
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2018 08:58:42 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id l25-v6so1736856ioh.12
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2018 15:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <1281327087.2168.67.camel@pasglop>
In-Reply-To: <1281327087.2168.67.camel@pasglop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Jun 2018 07:58:30 +0900
Message-ID: <CA+55aFxRyp4G4niZ=aMk+epdSbu5MB1oJg_h4NhLkxsM+f+SLQ@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2018 at 5:23 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

I love the alleged line removal, but there's nothing in that 'merge'
branch. It points to an ancient powerpc commit from 2016.

And please, signed tags. I know you do them, because you used to send me them.

             Linus
